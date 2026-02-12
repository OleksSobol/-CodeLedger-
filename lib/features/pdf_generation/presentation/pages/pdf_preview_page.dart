import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../providers/pdf_providers.dart';

class PdfPreviewPage extends ConsumerWidget {
  final int invoiceId;
  final String invoiceNumber;

  const PdfPreviewPage({
    super.key,
    required this.invoiceId,
    required this.invoiceNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice $invoiceNumber'),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(ref, format),
        canChangeOrientation: false,
        canDebug: false,
      ),
    );
  }

  Future<Uint8List> _generatePdf(WidgetRef ref, dynamic format) async {
    final doc = await ref.read(invoicePdfProvider(invoiceId).future);
    return doc.save();
  }
}
