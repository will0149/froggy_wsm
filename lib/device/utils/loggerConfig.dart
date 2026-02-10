import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var level = Level.off;

var logger = kDebugMode
    ? Logger(printer: PrettyPrinter())
    : Logger(printer: PrettyPrinter(), level: level);
