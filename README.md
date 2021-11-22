# Cairo Dart

Dart bindings to the Cairo C graphics library.

## Features

- Rendering lines, arcs, Bézier curves (cubic and quadratic).
- Saving to an image
- Transformations (rotation, translation, scaling, and any other matrix-described transformation)
- Fill and stroke (only solid color for now)

## Getting started

Currently, you have to compile Cairo directly. However, it may be changed in the future.

## Usage

```dart
// Load the cairo c library
CairoLib.load();

// Create a 640x320 surface / canvas
final img = ImageSurface(
  format: ImageFormat.ARGB32,
  width: 640,
  height: 360,
);

// render a magenta background
img.rectangle(Point(0, 0), img.width, img.height);
img.sourceColor = Color.magenta;
img.fill();

// save the image
img.save('out.png');

// destroy the image data in the RAM
img.destroy();
```

For more complicated examples, look at the `example/` folder.

## Additional information

Some of the functions cairo has aren't implemented yet. If you think a function needs to be added, you can create an issue explaining this.

This project is part of [Manim Web](https://github.com/manim-web).
