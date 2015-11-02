from __future__ import (absolute_import, division, print_function)

import numpy as np

import pyugrid
import pysgrid
from pysgrid.custom_exceptions import SGridNonCompliantError

from netCDF4 import Dataset
from shapely.geometry import MultiPolygon
from shapely.geometry.polygon import Polygon


__all__ = ['GridGeo',
           'load_grid']


class GridGeo(object):
    """
    GridGeo class takes a nc-like object (netCDF4-python or a netCDF
    file/URL) and parse the grid information.

    """
    def __init__(self, nc, mesh_name=None, precision=None):
        """
        Return a GridGeo class.
        `nc` : netCDF4-python object or a netCDF file/URL string
        `mesh_name` (string) : can me used to override the the netCDF
                               mesh_name attribute.
        `precision` (int) : truncates the geometry data to the specified
                            decimal places.

        """

        grid = load_grid(nc)
        if isinstance(grid, pyugrid.ugrid.UGrid):
            polygons = _parse_ugrid(grid, precision)
        elif isinstance(grid, pysgrid.sgrid.SGridND):
            # NOTE: We have 3 sgrid classes!!!  SGridND, SGrid2D, and
            # SGrid3D. Do we really need all that?
            polygons = _parse_sgrid(grid, precision)
        else:
            msg = 'Object {!r} does not seem to be a grid-like object.'
            raise msg(grid)

        # NOTE: Both pysgrid and pyugrid should have `mesh_name` property.
        if not mesh_name:
            try:
                mesh_name = grid.mesh_name
            except AttributeError:
                mesh_name = ''

        self.nc = nc
        self.grid = grid
        self.polygons = polygons
        self.mesh_name = mesh_name

    def __str__(self):
        return 'GeoGrid of {!r}'.format(self.nc)

    def __repr__(self):
        return self.polygons.__repr__()

    def _repr_svg_(self):
        return self.polygons._repr_svg_()

    def grid2geojson(self, **kw):
        """
        Return a GeoJSON representation of an s-/u-`grid` object.

        """
        # `kw` are based on the simplestyle-spec:
        # https://github.com/mapbox/simplestyle-spec/tree/master/1.1.0
        title = kw.pop('title', self.mesh_name)
        description = kw.pop('description', '')
        marker_size = kw.pop('marker-size', 'medium')
        marker_symbol = kw.pop('marker-symbol', '')
        marker_color = kw.pop('marker-color', '7e7e7e')
        stroke = kw.pop('stroke', '555555')
        stroke_opacity = kw.pop('stroke-opacity', 1)
        stroke_width = kw.pop('stroke-width', 2)
        fill = kw.pop('fill', '555555')
        fill_opacity = kw.pop('fill-opacity', 0.6)

        # FIXME: Folium/Leaflet.
        # popupContent = kw.pop('popupContent', '{!r}'.format(self.grid))
        # color = kw.pop('color', "#ffffff")

        geojson = {"type": "Feature",
                   "properties": {
                       "title": title,
                       "description": description,
                       "marker-size": marker_size,
                       "marker-symbol": marker_symbol,
                       "marker-color": marker_color,
                       "stroke": stroke,
                       "stroke-opacity": stroke_opacity,
                       "stroke-width": stroke_width,
                       "fill": fill,
                       "fill-opacity": fill_opacity,
                       },
                   "geometry": self.polygons.__geo_interface__}
        return geojson

    def grid2shapely(self):
        """
        Return a shapely representation of an s-/u-`grid` object.

        """
        return self.polygons


def load_grid(nc):
    """
    Takes a `nc` netCDF4-python object or a file/URL path and returns
    either `pyugrid` or `pysgrid` object depending on the grid type.

    load_grid will return `None` if the grid is unknown, unidentified,
    or if there is no grid.  Not sure if this is a good idea, but I'd rather
    not raise anything here for now.

    """
    grid = None

    # NOTE: I'd love if this was the default behavior of pyugrid and
    # pysgrid.  Maybe even netCDF4-python...
    if isinstance(nc, Dataset):
        pass
    else:
        nc = Dataset(nc)

    try:  # SGRID.
        grid = pysgrid.from_nc_dataset(nc)
        # This is the problem with custom exceptions it hides what is really
        # happening.  The KeyError must be catch and re-raised as
        # ValueError, since this is a value missing in the netCDF file.
        # And the error message must reflect what pysgrid was expecting to
        # find here.
    except (SGridNonCompliantError, KeyError):
        pass
    try:  # UGRID.
        grid = pyugrid.UGrid.from_nc_dataset(nc)
    except ValueError:
        pass
    return grid


def _parse_ugrid(ugrid, precision):
    """
    The `ugrid` object is parsed as a shapely `MultiPolygon` containing
    several `Polygon`s, for example, the triangles of a triangular mesh.

    """
    lon = ugrid.nodes[:, 0]
    lat = ugrid.nodes[:, 1]
    triangles = ugrid.faces[:]

    if precision:
        lon = np.round(lon, decimals=precision)
        lat = np.round(lat, decimals=precision)

    # NOTE: This loop can be slow.  Numba @jit can reduce it in half.
    polygons = MultiPolygon([Polygon(zip(lon[k], lat[k])) for
                            k in triangles])
    return polygons


def _parse_sgrid(sgrid, precision):
    """
    The `sgrid` object is parsed as a collection (`MultiPolygon`) of
    triangles (`Polygon`).

    NOTE: Works only for the grid center because sgrid does not provide an
    agnostic way to access the edges.

    """
    coords = sgrid.centers.copy()

    if precision:
        coords = np.round(coords, decimals=precision)

    M, N, L = coords.shape
    points = np.concatenate((coords[0:-1, 0:-1],
                             coords[0:-1, 1:],
                             coords[1:, 1:],
                             coords[1:, 0:-1],
                             coords[0:-1, 0:-1]), axis=L)

    points = points.reshape((M-1 * N-1, 5, L))

    # NOTE: This loop can be slow.  Numba @jit can reduce it in half.
    polygons = []
    for p in points:
        polygons.append(Polygon(p))
    return MultiPolygon(polygons)
