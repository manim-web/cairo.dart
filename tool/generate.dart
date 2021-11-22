import 'dart:io';

import 'package:process_run/shell.dart';
import 'package:yaml/yaml.dart';

void main() async {
  final shell = Shell();
  final yamlFile = await File('./pubspec.yaml').readAsString();
  final file = loadYaml(yamlFile)['ffigen']['output'] as String;

  //? Get latest cairo version

  await shell.run('dart run ffigen');

  await shell.run('dart format $file');
}
