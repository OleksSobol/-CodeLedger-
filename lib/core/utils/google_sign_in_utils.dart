import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

final googleSignIn = GoogleSignIn(scopes: [drive.DriveApi.driveFileScope]);

Future<void> ensureGoogleSignInInitialized() async {
  // Not needed in 6.2.1
}
