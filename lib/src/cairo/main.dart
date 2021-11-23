import 'dart:ffi';
import 'dart:io';

import 'package:cairo/src/cairo/generated_bindings.dart';

export 'package:cairo/src/cairo/generated_bindings.dart' hide Cairo;

class CairoLib {
  static late Cairo cairo;
  static late DynamicLibrary dynamicLibrary;

  //? Automatically load the library if not done?
  static load([String? libFile]) {
    if (libFile == null) {
      libFile = 'libcairo.so'; // on linux


      if (Platform.isMacOS) {
        libFile = 'cairo.dylib';
      } else if (Platform.isWindows) {
        libFile = 'cairo.dll';
      }
    }

    dynamicLibrary = DynamicLibrary.open(libFile);
    cairo = Cairo(dynamicLibrary);
  }

  CairoLib._();
}
