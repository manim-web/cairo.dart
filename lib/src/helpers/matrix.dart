import 'dart:ffi';

import 'package:cairo/src/third-party/cairo/main.dart';
import 'package:ffi/ffi.dart';

class Matrix {
  Pointer<cairo_matrix_t> _mat;

  Matrix({
    double xx = 1,
    double yx = 0,
    double xy = 0,
    double yy = 1,
    double x0 = 0,
    double y0 = 0,
  }) : _mat = malloc() {
    _mat.ref.xx = xx;
    _mat.ref.xy = xy;
    _mat.ref.yx = yx;
    _mat.ref.yy = yy;
    _mat.ref.x0 = x0;
    _mat.ref.y0 = y0;
  }
  double get xx => _mat.ref.xx;
  double get xy => _mat.ref.xy;
  double get yx => _mat.ref.yx;
  double get yy => _mat.ref.yy;
  double get x0 => _mat.ref.x0;
  double get y0 => _mat.ref.y0;

  set xx(double val) => _mat.ref.xx = val;
  set xy(double val) => _mat.ref.xy = val;
  set yx(double val) => _mat.ref.yx = val;
  set yy(double val) => _mat.ref.yy = val;
  set x0(double val) => _mat.ref.x0 = val;
  set y0(double val) => _mat.ref.y0 = val;

  /// __Important:__
  /// To avoid memory leaks, `matrix.destroy` needs to be called
  /// if the matrix won't be used after such that the used memory
  /// is freed
  void destroy() => malloc.free(_mat);

  Pointer<cairo_matrix_t> get pointer => _mat;
}
