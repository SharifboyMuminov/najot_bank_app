import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (canAuthenticate) {
      List<BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) return true;
    }
    return false;
  }

  static Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: "Barmoq izi yoki yuzni tanish usulini faollashtiring!",
        // assuming AuthenticationOptions is defined somewhere else
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint("BIOMETRICS ERROR:${e.code}");
      if (e.code == auth_error.notAvailable) {
        // Handle not available error
      } else if (e.code == auth_error.notEnrolled) {
        // Handle not enrolled error
      } else {
        // Handle other errors
      }
      return false;
    }
  }
}
