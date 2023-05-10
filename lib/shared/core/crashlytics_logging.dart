import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsLogging {
  CrashlyticsLogging._();

  static CrashlyticsLogging get instance => CrashlyticsLogging._();

  Future<void> recordError({String? message, StackTrace? stackTrace}) async {
    await FirebaseCrashlytics.instance.recordFlutterFatalError(
      FlutterErrorDetails(
        exception: message ?? 'Error',
        stack: stackTrace,
      ),
    );
  }
}
