import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share_plus/share_plus.dart';

class EmailService {
  Future<void> sendInvoice({
    required File file,
    required String subject,
    required String body,
    List<String> recipients = const [],
  }) async {
    // Try to send via native email client first (better UX on mobile)
    try {
      final email = Email(
        body: body,
        subject: subject,
        recipients: recipients,
        attachmentPaths: [file.path],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    } catch (e) {
      // Fallback to share_plus (works on Windows/Desktop and if no email app configured)
      // On Windows, this opens the system share dialog which includes Mail.
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: subject,
          text: body,
        ),
      );
    }
  }
}
