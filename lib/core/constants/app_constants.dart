abstract class AppConstants {
  static const String appName = 'CodeLedger';
  static const String dbFileName = 'code_ledger.sqlite';

  // Payment terms options
  static const Map<String, int> paymentTerms = {
    'net_7': 7,
    'net_14': 14,
    'net_30': 30,
  };

  // Invoice statuses
  static const String statusDraft = 'draft';
  static const String statusSent = 'sent';
  static const String statusPaid = 'paid';
  static const String statusOverdue = 'overdue';
  static const String statusCancelled = 'cancelled';

  // Payment methods
  static const String paymentAch = 'ach';
  static const String paymentStripe = 'stripe';
  static const String paymentOther = 'other';

  // Bank account types
  static const String accountChecking = 'checking';
  static const String accountSavings = 'savings';

  // Template types
  static const String templateMinimal = 'minimal';
  static const String templateDetailed = 'detailed';
  static const String templateModernDev = 'modern_developer';

  // Google Drive
  static const String driveFolder = 'CodeLedger';
  static const String backupFilePrefix = 'codeledger_backup_';
  static const String backupFileExtension = '.enc';
}
