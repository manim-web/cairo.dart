import 'package:cairo/cairo.dart';

void main() {
  // Load the cairo c library
  CairoLib.load();

  // Create a 640x320 surface / canvas
  final img = ImageSurface(
    format: ImageFormat.ARGB32,
    width: 640,
    height: 360,
  );

  // render background
  img.rectangle(Point(0, 0), img.width, img.height);
  img.sourceColor = Color.white;
  img.fill();

  // start a new path
  img.startPath();

  // move cursor (aka cairo's drawing pen) to (100, 100)
  img.moveTo(Point(100, 100));

  // line from (100,100) to (200,200) then to (200, 300)
  img.lineTo(Point(200, 200));
  img.lineTo(Point(200, 300));

  // quadratic bezier curve from the current cursor position (here: 200, 300)
  // to the point (420, 300) with a "handle" at (250, 250)
  // TODO this seems to mess up the path closing
  // TODO figure out why
  img.quadCurveTo(Point(250, 250), Point(420, 300));

  // cubic bezier curve from the current cursor position (here: 420, 300)
  // to the point (300, 150) with the first "handle" at (400, 200)
  // and the second "handle" at (100, 200)
  img.cubicCurveTo(Point(400, 200), Point(100, 200), Point(300, 150));

  // close the path with a straight line from the current cursor position
  // to the start of the path
  img.closePath();

  // add a 3px wide magenta border along the path described
  // with preserve, the path is kept in memory by cairo
  // such that it can be used later for another fill / stroke
  img.lineWidth = 3;
  img.sourceColor = Color.magenta;
  img.stroke(preserve: true);

  // fill the path (preserved) with a cyan color with 50% opacity
  img.sourceColor = Color.cyan.withTransparency(0.5);
  img.fill();

  // save the image
  img.save('out.png');

  // destroy the image data in the RAM
  img.destroy();
}
