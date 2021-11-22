import 'dart:ffi';

import 'package:cairo/src/surfaces/surface.dart';
import 'package:cairo/src/third-party/cairo/main.dart';

enum ImageFormat { ARGB32, RGB24, A8, A1, RGB16_565, RGB30, RGB96F, RGBA128F }

class ImageSurface extends Surface {
  ImageFormat format;
  int width, height;

  ImageSurface({
    required this.format,
    required this.width,
    required this.height,
  });

  @override
  Pointer<cairo_surface_t> createSurface() =>
      CairoLib.cairo.cairo_image_surface_create(
        _formatMap[format]!,
        width,
        height,
      );
}

final _formatMap = <ImageFormat, int>{
  ImageFormat.ARGB32: cairo_format.CAIRO_FORMAT_ARGB32,
  ImageFormat.RGB24: cairo_format.CAIRO_FORMAT_RGB24,
  ImageFormat.A8: cairo_format.CAIRO_FORMAT_A8,
  ImageFormat.A1: cairo_format.CAIRO_FORMAT_A1,
  ImageFormat.RGB16_565: cairo_format.CAIRO_FORMAT_RGB16_565,
  ImageFormat.RGB30: cairo_format.CAIRO_FORMAT_RGB30,
  ImageFormat.RGB96F: cairo_format.CAIRO_FORMAT_RGB96F,
  ImageFormat.RGBA128F: cairo_format.CAIRO_FORMAT_RGBA128F,
};
