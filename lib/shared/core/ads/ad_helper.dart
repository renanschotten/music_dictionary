import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3902688296591672/9243630622';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
