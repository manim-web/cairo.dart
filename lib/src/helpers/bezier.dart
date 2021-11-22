import 'dart:math';

class CubicBezier {
  // p1 is the first handle
  // p2 is the second handle
  // p0 is the first anchor
  // p3 is the second anchor

  Point p0, p1, p2, p3;

  CubicBezier(this.p0, this.p1, this.p2, this.p3);
}

CubicBezier getCubicBezierFromQuadratic(Point q0, Point q1, Point q2) {
  return CubicBezier(q0, q0 + (q1 - q0).asDouble * (2 / 3),
      q2 + (q1 - q2).asDouble * (2 / 3), q2);
}

extension DoublePoint on Point {
  Point<double> get asDouble => Point(x.toDouble(), y.toDouble());
}
