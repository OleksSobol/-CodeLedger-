import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/invoice_dao.dart';
import '../../../../core/database/daos/user_profile_dao.dart';
import '../../../../core/database/daos/invoice_template_dao.dart';
import '../domain/pdf_generator_strategy.dart';
import '../domain/templates/minimal_template.dart';
import '../domain/templates/detailed_template.dart';
import '../domain/templates/modern_template.dart';

class PdfService {
  final InvoiceDao _invoiceDao;
  final UserProfileDao _userProfileDao;
  final InvoiceTemplateDao _templateDao;

  PdfService(this._invoiceDao, this._userProfileDao, this._templateDao);

  /// Generates a PDF for the given [invoiceId].
  ///
  /// Fetches all necessary data (Invoice, Client, UserProfile, Template)
  /// and delegates to the appropriate [PdfGeneratorStrategy].
  Future<Uint8List> generateInvoicePdf(int invoiceId) async {
    // 1. Fetch Invoice and related data
    final invoice = await _invoiceDao.getInvoice(invoiceId);
    // InvoiceDAO.getInvoice returns non-nullable Invoice based on generated code usually
    // if using .getSingle().
    
    final lineItems = await _invoiceDao.getLineItemsWithDetails(invoiceId);
    
    // We need the client too. InvoiceDao uses joins in some methods but let's fetch strictly.
    // Assuming Invoice has a clientId.
    // Fetch user profile
    final userProfile = await _userProfileDao.getProfile();
    
    // Fetch full client details (address etc)
    // We might need a ClientDao or access it via the DB instance if simpler
    final db = _invoiceDao.db;
    final client = await (db.select(db.clients)..where((c) => c.id.equals(invoice.clientId))).getSingle();

    // 2. Determine Template
    // Priority: Invoice-specific template -> Client default -> User global default -> System default
    InvoiceTemplate? template;
    
    // (We could add a templateId column to Invoices table later for per-invoice overrides, 
    // but for now let's use the Client's default or User's default)
    if (client.defaultTemplateId != null) {
       template = await _templateDao.getById(client.defaultTemplateId!);
    }
    
    if (template == null && userProfile.defaultTemplateId != null) {
      template = await _templateDao.getById(userProfile.defaultTemplateId!);
    }

    // Fallback to minimal if nothing configured
    template ??= await _templateDao.getByKey('minimal') ?? await _templateDao.getDefault();

    if (template == null) {
       // Absolute fallback if DB is empty
       throw Exception('No invoice templates found in database');
    }

    // 3. Select Strategy
    final PdfGeneratorStrategy strategy = _getStrategy(template.templateKey);

    // 4. Generate
    return strategy.generate(
      invoice: invoice,
      client: client,
      userProfile: userProfile,
      lineItems: lineItems,
      template: template,
    );
  }

  PdfGeneratorStrategy _getStrategy(String templateKey) {
    switch (templateKey) {
      case 'detailed':
        return DetailedTemplate();
      case 'modern_developer':
        return ModernTemplate();
      case 'minimal':
      default:
        return MinimalTemplate();
    }
  }
}
