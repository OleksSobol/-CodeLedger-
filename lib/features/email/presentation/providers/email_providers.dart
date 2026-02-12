import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/email_service.dart';

final emailServiceProvider = Provider<EmailService>((ref) {
  return EmailService();
});
