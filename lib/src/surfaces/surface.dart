import 'dart:ffi';
import 'dart:math';

import 'package:cairo/src/helpers/bezier.dart';
import 'package:cairo/src/helpers/colors.dart';
import 'package:cairo/src/helpers/matrix.dart';
import 'package:cairo/src/third-party/cairo/generated_bindings.dart';
import 'package:cairo/src/third-party/cairo/main.dart';
import 'package:ffi/ffi.dart';

abstract class Surface {
  late final Pointer<cairo_t> cr;
  late final Pointer<cairo_surface_t> surface;

  Surface() {
    surface = createSurface();
    cr = cairo.cairo_create(surface);
  }

  Cairo get cairo => CairoLib.cairo;

  Pointer<cairo_surface_t> createSurface();

  void save(String filePath) {
    final filename = filePath.toNativeUtf8();
    cairo.cairo_surface_write_to_png(surface, filename.cast());
    malloc.free(filename);
  }

  void destroy() {
    cairo.cairo_surface_destroy(surface);
    cairo.cairo_destroy(cr);
  }

  void scale(num x, num y) => cairo.cairo_scale(cr, x.toDouble(), y.toDouble());
  void translate(Point pt) =>
      cairo.cairo_translate(cr, pt.x.toDouble(), pt.y.toDouble());
  void rotate(num angle) => cairo.cairo_rotate(cr, angle.toDouble());

  Matrix get matrix {
    final mat = Matrix();

    cairo.cairo_get_matrix(cr, mat.pointer);

    return mat;
  }

  set matrix(Matrix mat) => cairo.cairo_set_matrix(cr, matrix.pointer);

  Point get currentPosition {
    final x = calloc<Double>();
    final y = calloc<Double>();
    cairo.cairo_get_current_point(cr, x, y);

    final pt = Point(x.value, y.value);

    calloc.free(x);
    calloc.free(y);

    return pt;
  }

  double get lineWidth => cairo.cairo_get_line_width(cr);
  set lineWidth(num w) => cairo.cairo_set_line_width(cr, w.toDouble());
  set sourceColor(Color color) =>
      cairo.cairo_set_source_rgba(cr, color.r, color.g, color.b, color.a);

  void moveTo(Point pt) =>
      cairo.cairo_move_to(cr, pt.x.toDouble(), pt.y.toDouble());
  void lineTo(Point pt) =>
      cairo.cairo_line_to(cr, pt.x.toDouble(), pt.y.toDouble());

  void cubicCurveTo(Point a, Point b, Point c) => cairo.cairo_curve_to(
      cr,
      a.x.toDouble(),
      a.y.toDouble(),
      b.x.toDouble(),
      b.y.toDouble(),
      c.x.toDouble(),
      c.y.toDouble());

  void quadCurveTo(Point handle, Point anchor) =>
      quadCurve(currentPosition, handle, anchor);

  void quadCurve(
    Point anchor1,
    Point handle,
    Point anchor2,
  ) {
    final cubic = getCubicBezierFromQuadratic(anchor1, handle, anchor2);
    cubicCurve(cubic.p0, cubic.p1, cubic.p2, cubic.p3);
  }

  void cubicCurve(
    Point p0,
    Point p1,
    Point p2,
    Point p3,
  ) {
    moveTo(p0);
    cubicCurveTo(p1, p2, p3);
  }

  void lineFromTo(Point a, Point b) {
    moveTo(a);
    lineTo(b);
  }

  void rectangle(Point origin, num width, num height) => cairo.cairo_rectangle(
        cr,
        origin.x.toDouble(),
        origin.y.toDouble(),
        width.toDouble(),
        height.toDouble(),
      );

  void circle(Point origin, num radius) {
    arc(origin, radius, 0, 2 * pi);
  }

  void arc(Point origin, num radius, num start, num end) => cairo.cairo_arc(
        cr,
        origin.x.toDouble(),
        origin.y.toDouble(),
        radius.toDouble(),
        start.toDouble(),
        end.toDouble(),
      );

  void stroke({bool preserve = false}) {
    if (preserve) {
      cairo.cairo_stroke_preserve(cr);
    } else {
      cairo.cairo_stroke(cr);
    }
  }

  void fill({bool preserve = false}) {
    if (preserve) {
      cairo.cairo_fill_preserve(cr);
    } else {
      cairo.cairo_fill(cr);
    }
  }

  void startPath() => cairo.cairo_new_path(cr);
  void closePath() => cairo.cairo_close_path(cr);
  void startSubPath() => cairo.cairo_new_sub_path(cr);
}
