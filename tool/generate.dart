import 'dart:io';

import 'package:path/path.dart';
import 'package:ffigen/ffigen.dart';
import 'package:ffigen/src/executables/ffigen.dart';
import 'package:http/http.dart';

final headerFiles = <String>[
  'src/cairo.h',
  'src/cairo-deprecated.h',
  'src/cairo-version.h'
];
final githubUrl = 'https://raw.githubusercontent.com/freedesktop/cairo/master';

void main() async {
  final config = getConfigFromPubspec();
  final library = parse(config);

  final cairoDir = await Directory('./third-party').create();

  final http = Client();
  for (final fileName in headerFiles) {
    final url = Uri.parse('$githubUrl/$fileName');
    final data = await http.get(url);

    await File(join(cairoDir.path, basename(fileName)))
        .writeAsString(data.body);
  }

  final startFile = File(join(cairoDir.path, 'cairo.h'));

  await startFile.writeAsString(
    (await startFile.readAsString()).replaceFirst(
      '#include "cairo-features.h"',
      '#define CAIRO_HAS_PNG_FUNCTIONS 1',
    ),
  );

  final out = File(config.output);
  library.generateFile(out);
}
