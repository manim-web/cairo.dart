import 'dart:ffi';
import 'dart:io';

import 'package:cairo/src/third-party/cairo/generated_bindings.dart';

export 'package:cairo/src/third-party/cairo/generated_bindings.dart' hide Cairo;

class CairoLib {
  static late Cairo cairo;
  static late DynamicLibrary dynamicLibrary;

  //? Automatically load the library if not done?
  static load([String? libFile]) {
    if (libFile == null) {
      libFile = '/usr/local/lib/libcairo.so'; // on linux

      // TODO: figure out where those files are located

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
