class Color {
  final double r, g, b, a; // from 0 to 1

  const Color({required this.r, required this.g, required this.b, this.a = 1});

  factory Color.gray([double factor = 0.5]) =>
      Color(r: factor, g: factor, b: factor);

  static Color white = Color(r: 1, g: 1, b: 1);
  static Color black = Color(r: 0, g: 0, b: 0);

  static Color red = Color(r: 1, g: 0, b: 0);
  static Color green = Color(r: 0, g: 1, b: 0);
  static Color blue = Color(r: 0, g: 0, b: 1);

  static Color magenta = Color(r: 1, g: 0, b: 1);
  static Color yellow = Color(r: 1, g: 1, b: 0);
  static Color cyan = Color(r: 0, g: 1, b: 1);

  static Color transparent = black.withTransparency(0);

  Color withTransparency(double transparency) =>
      Color(r: r, g: g, b: b, a: transparency);
}
