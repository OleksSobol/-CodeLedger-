// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $InvoiceTemplatesTable extends InvoiceTemplates
    with TableInfo<$InvoiceTemplatesTable, InvoiceTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateKeyMeta = const VerificationMeta(
    'templateKey',
  );
  @override
  late final GeneratedColumn<String> templateKey = GeneratedColumn<String>(
    'template_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _primaryColorMeta = const VerificationMeta(
    'primaryColor',
  );
  @override
  late final GeneratedColumn<int> primaryColor = GeneratedColumn<int>(
    'primary_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF2196F3),
  );
  static const VerificationMeta _accentColorMeta = const VerificationMeta(
    'accentColor',
  );
  @override
  late final GeneratedColumn<int> accentColor = GeneratedColumn<int>(
    'accent_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF1565C0),
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta(
    'fontFamily',
  );
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Helvetica'),
  );
  static const VerificationMeta _showLogoMeta = const VerificationMeta(
    'showLogo',
  );
  @override
  late final GeneratedColumn<bool> showLogo = GeneratedColumn<bool>(
    'show_logo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_logo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showPaymentInfoMeta = const VerificationMeta(
    'showPaymentInfo',
  );
  @override
  late final GeneratedColumn<bool> showPaymentInfo = GeneratedColumn<bool>(
    'show_payment_info',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_payment_info" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showTaxBreakdownMeta = const VerificationMeta(
    'showTaxBreakdown',
  );
  @override
  late final GeneratedColumn<bool> showTaxBreakdown = GeneratedColumn<bool>(
    'show_tax_breakdown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_tax_breakdown" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showTaxIdMeta = const VerificationMeta(
    'showTaxId',
  );
  @override
  late final GeneratedColumn<bool> showTaxId = GeneratedColumn<bool>(
    'show_tax_id',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_tax_id" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showBusinessLicenseMeta =
      const VerificationMeta('showBusinessLicense');
  @override
  late final GeneratedColumn<bool> showBusinessLicense = GeneratedColumn<bool>(
    'show_business_license',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_business_license" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _showBankDetailsMeta = const VerificationMeta(
    'showBankDetails',
  );
  @override
  late final GeneratedColumn<bool> showBankDetails = GeneratedColumn<bool>(
    'show_bank_details',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_bank_details" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showStripeLinkMeta = const VerificationMeta(
    'showStripeLink',
  );
  @override
  late final GeneratedColumn<bool> showStripeLink = GeneratedColumn<bool>(
    'show_stripe_link',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_stripe_link" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _showDetailedBreakdownMeta =
      const VerificationMeta('showDetailedBreakdown');
  @override
  late final GeneratedColumn<bool> showDetailedBreakdown =
      GeneratedColumn<bool>(
        'show_detailed_breakdown',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_detailed_breakdown" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _showPaymentTermsMeta = const VerificationMeta(
    'showPaymentTerms',
  );
  @override
  late final GeneratedColumn<bool> showPaymentTerms = GeneratedColumn<bool>(
    'show_payment_terms',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_payment_terms" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showLateFeeClauseMeta = const VerificationMeta(
    'showLateFeeClause',
  );
  @override
  late final GeneratedColumn<bool> showLateFeeClause = GeneratedColumn<bool>(
    'show_late_fee_clause',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_late_fee_clause" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _footerTextMeta = const VerificationMeta(
    'footerText',
  );
  @override
  late final GeneratedColumn<String> footerText = GeneratedColumn<String>(
    'footer_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    templateKey,
    description,
    isDefault,
    primaryColor,
    accentColor,
    fontFamily,
    showLogo,
    showPaymentInfo,
    showTaxBreakdown,
    showTaxId,
    showBusinessLicense,
    showBankDetails,
    showStripeLink,
    showDetailedBreakdown,
    showPaymentTerms,
    showLateFeeClause,
    footerText,
    isBuiltIn,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('template_key')) {
      context.handle(
        _templateKeyMeta,
        templateKey.isAcceptableOrUnknown(
          data['template_key']!,
          _templateKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateKeyMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('primary_color')) {
      context.handle(
        _primaryColorMeta,
        primaryColor.isAcceptableOrUnknown(
          data['primary_color']!,
          _primaryColorMeta,
        ),
      );
    }
    if (data.containsKey('accent_color')) {
      context.handle(
        _accentColorMeta,
        accentColor.isAcceptableOrUnknown(
          data['accent_color']!,
          _accentColorMeta,
        ),
      );
    }
    if (data.containsKey('font_family')) {
      context.handle(
        _fontFamilyMeta,
        fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta),
      );
    }
    if (data.containsKey('show_logo')) {
      context.handle(
        _showLogoMeta,
        showLogo.isAcceptableOrUnknown(data['show_logo']!, _showLogoMeta),
      );
    }
    if (data.containsKey('show_payment_info')) {
      context.handle(
        _showPaymentInfoMeta,
        showPaymentInfo.isAcceptableOrUnknown(
          data['show_payment_info']!,
          _showPaymentInfoMeta,
        ),
      );
    }
    if (data.containsKey('show_tax_breakdown')) {
      context.handle(
        _showTaxBreakdownMeta,
        showTaxBreakdown.isAcceptableOrUnknown(
          data['show_tax_breakdown']!,
          _showTaxBreakdownMeta,
        ),
      );
    }
    if (data.containsKey('show_tax_id')) {
      context.handle(
        _showTaxIdMeta,
        showTaxId.isAcceptableOrUnknown(data['show_tax_id']!, _showTaxIdMeta),
      );
    }
    if (data.containsKey('show_business_license')) {
      context.handle(
        _showBusinessLicenseMeta,
        showBusinessLicense.isAcceptableOrUnknown(
          data['show_business_license']!,
          _showBusinessLicenseMeta,
        ),
      );
    }
    if (data.containsKey('show_bank_details')) {
      context.handle(
        _showBankDetailsMeta,
        showBankDetails.isAcceptableOrUnknown(
          data['show_bank_details']!,
          _showBankDetailsMeta,
        ),
      );
    }
    if (data.containsKey('show_stripe_link')) {
      context.handle(
        _showStripeLinkMeta,
        showStripeLink.isAcceptableOrUnknown(
          data['show_stripe_link']!,
          _showStripeLinkMeta,
        ),
      );
    }
    if (data.containsKey('show_detailed_breakdown')) {
      context.handle(
        _showDetailedBreakdownMeta,
        showDetailedBreakdown.isAcceptableOrUnknown(
          data['show_detailed_breakdown']!,
          _showDetailedBreakdownMeta,
        ),
      );
    }
    if (data.containsKey('show_payment_terms')) {
      context.handle(
        _showPaymentTermsMeta,
        showPaymentTerms.isAcceptableOrUnknown(
          data['show_payment_terms']!,
          _showPaymentTermsMeta,
        ),
      );
    }
    if (data.containsKey('show_late_fee_clause')) {
      context.handle(
        _showLateFeeClauseMeta,
        showLateFeeClause.isAcceptableOrUnknown(
          data['show_late_fee_clause']!,
          _showLateFeeClauseMeta,
        ),
      );
    }
    if (data.containsKey('footer_text')) {
      context.handle(
        _footerTextMeta,
        footerText.isAcceptableOrUnknown(data['footer_text']!, _footerTextMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      templateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_key'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      primaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}primary_color'],
      )!,
      accentColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accent_color'],
      )!,
      fontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      )!,
      showLogo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_logo'],
      )!,
      showPaymentInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_payment_info'],
      )!,
      showTaxBreakdown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_tax_breakdown'],
      )!,
      showTaxId: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_tax_id'],
      )!,
      showBusinessLicense: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_business_license'],
      )!,
      showBankDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_bank_details'],
      )!,
      showStripeLink: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_stripe_link'],
      )!,
      showDetailedBreakdown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_detailed_breakdown'],
      )!,
      showPaymentTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_payment_terms'],
      )!,
      showLateFeeClause: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_late_fee_clause'],
      )!,
      footerText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}footer_text'],
      ),
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InvoiceTemplatesTable createAlias(String alias) {
    return $InvoiceTemplatesTable(attachedDatabase, alias);
  }
}

class InvoiceTemplate extends DataClass implements Insertable<InvoiceTemplate> {
  final int id;
  final String name;
  final String templateKey;
  final String? description;
  final bool isDefault;
  final int primaryColor;
  final int accentColor;
  final String fontFamily;
  final bool showLogo;
  final bool showPaymentInfo;
  final bool showTaxBreakdown;
  final bool showTaxId;
  final bool showBusinessLicense;
  final bool showBankDetails;
  final bool showStripeLink;
  final bool showDetailedBreakdown;
  final bool showPaymentTerms;
  final bool showLateFeeClause;
  final String? footerText;
  final bool isBuiltIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InvoiceTemplate({
    required this.id,
    required this.name,
    required this.templateKey,
    this.description,
    required this.isDefault,
    required this.primaryColor,
    required this.accentColor,
    required this.fontFamily,
    required this.showLogo,
    required this.showPaymentInfo,
    required this.showTaxBreakdown,
    required this.showTaxId,
    required this.showBusinessLicense,
    required this.showBankDetails,
    required this.showStripeLink,
    required this.showDetailedBreakdown,
    required this.showPaymentTerms,
    required this.showLateFeeClause,
    this.footerText,
    required this.isBuiltIn,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['template_key'] = Variable<String>(templateKey);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['primary_color'] = Variable<int>(primaryColor);
    map['accent_color'] = Variable<int>(accentColor);
    map['font_family'] = Variable<String>(fontFamily);
    map['show_logo'] = Variable<bool>(showLogo);
    map['show_payment_info'] = Variable<bool>(showPaymentInfo);
    map['show_tax_breakdown'] = Variable<bool>(showTaxBreakdown);
    map['show_tax_id'] = Variable<bool>(showTaxId);
    map['show_business_license'] = Variable<bool>(showBusinessLicense);
    map['show_bank_details'] = Variable<bool>(showBankDetails);
    map['show_stripe_link'] = Variable<bool>(showStripeLink);
    map['show_detailed_breakdown'] = Variable<bool>(showDetailedBreakdown);
    map['show_payment_terms'] = Variable<bool>(showPaymentTerms);
    map['show_late_fee_clause'] = Variable<bool>(showLateFeeClause);
    if (!nullToAbsent || footerText != null) {
      map['footer_text'] = Variable<String>(footerText);
    }
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InvoiceTemplatesCompanion toCompanion(bool nullToAbsent) {
    return InvoiceTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      templateKey: Value(templateKey),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isDefault: Value(isDefault),
      primaryColor: Value(primaryColor),
      accentColor: Value(accentColor),
      fontFamily: Value(fontFamily),
      showLogo: Value(showLogo),
      showPaymentInfo: Value(showPaymentInfo),
      showTaxBreakdown: Value(showTaxBreakdown),
      showTaxId: Value(showTaxId),
      showBusinessLicense: Value(showBusinessLicense),
      showBankDetails: Value(showBankDetails),
      showStripeLink: Value(showStripeLink),
      showDetailedBreakdown: Value(showDetailedBreakdown),
      showPaymentTerms: Value(showPaymentTerms),
      showLateFeeClause: Value(showLateFeeClause),
      footerText: footerText == null && nullToAbsent
          ? const Value.absent()
          : Value(footerText),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InvoiceTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      templateKey: serializer.fromJson<String>(json['templateKey']),
      description: serializer.fromJson<String?>(json['description']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      primaryColor: serializer.fromJson<int>(json['primaryColor']),
      accentColor: serializer.fromJson<int>(json['accentColor']),
      fontFamily: serializer.fromJson<String>(json['fontFamily']),
      showLogo: serializer.fromJson<bool>(json['showLogo']),
      showPaymentInfo: serializer.fromJson<bool>(json['showPaymentInfo']),
      showTaxBreakdown: serializer.fromJson<bool>(json['showTaxBreakdown']),
      showTaxId: serializer.fromJson<bool>(json['showTaxId']),
      showBusinessLicense: serializer.fromJson<bool>(
        json['showBusinessLicense'],
      ),
      showBankDetails: serializer.fromJson<bool>(json['showBankDetails']),
      showStripeLink: serializer.fromJson<bool>(json['showStripeLink']),
      showDetailedBreakdown: serializer.fromJson<bool>(
        json['showDetailedBreakdown'],
      ),
      showPaymentTerms: serializer.fromJson<bool>(json['showPaymentTerms']),
      showLateFeeClause: serializer.fromJson<bool>(json['showLateFeeClause']),
      footerText: serializer.fromJson<String?>(json['footerText']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'templateKey': serializer.toJson<String>(templateKey),
      'description': serializer.toJson<String?>(description),
      'isDefault': serializer.toJson<bool>(isDefault),
      'primaryColor': serializer.toJson<int>(primaryColor),
      'accentColor': serializer.toJson<int>(accentColor),
      'fontFamily': serializer.toJson<String>(fontFamily),
      'showLogo': serializer.toJson<bool>(showLogo),
      'showPaymentInfo': serializer.toJson<bool>(showPaymentInfo),
      'showTaxBreakdown': serializer.toJson<bool>(showTaxBreakdown),
      'showTaxId': serializer.toJson<bool>(showTaxId),
      'showBusinessLicense': serializer.toJson<bool>(showBusinessLicense),
      'showBankDetails': serializer.toJson<bool>(showBankDetails),
      'showStripeLink': serializer.toJson<bool>(showStripeLink),
      'showDetailedBreakdown': serializer.toJson<bool>(showDetailedBreakdown),
      'showPaymentTerms': serializer.toJson<bool>(showPaymentTerms),
      'showLateFeeClause': serializer.toJson<bool>(showLateFeeClause),
      'footerText': serializer.toJson<String?>(footerText),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InvoiceTemplate copyWith({
    int? id,
    String? name,
    String? templateKey,
    Value<String?> description = const Value.absent(),
    bool? isDefault,
    int? primaryColor,
    int? accentColor,
    String? fontFamily,
    bool? showLogo,
    bool? showPaymentInfo,
    bool? showTaxBreakdown,
    bool? showTaxId,
    bool? showBusinessLicense,
    bool? showBankDetails,
    bool? showStripeLink,
    bool? showDetailedBreakdown,
    bool? showPaymentTerms,
    bool? showLateFeeClause,
    Value<String?> footerText = const Value.absent(),
    bool? isBuiltIn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InvoiceTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    templateKey: templateKey ?? this.templateKey,
    description: description.present ? description.value : this.description,
    isDefault: isDefault ?? this.isDefault,
    primaryColor: primaryColor ?? this.primaryColor,
    accentColor: accentColor ?? this.accentColor,
    fontFamily: fontFamily ?? this.fontFamily,
    showLogo: showLogo ?? this.showLogo,
    showPaymentInfo: showPaymentInfo ?? this.showPaymentInfo,
    showTaxBreakdown: showTaxBreakdown ?? this.showTaxBreakdown,
    showTaxId: showTaxId ?? this.showTaxId,
    showBusinessLicense: showBusinessLicense ?? this.showBusinessLicense,
    showBankDetails: showBankDetails ?? this.showBankDetails,
    showStripeLink: showStripeLink ?? this.showStripeLink,
    showDetailedBreakdown: showDetailedBreakdown ?? this.showDetailedBreakdown,
    showPaymentTerms: showPaymentTerms ?? this.showPaymentTerms,
    showLateFeeClause: showLateFeeClause ?? this.showLateFeeClause,
    footerText: footerText.present ? footerText.value : this.footerText,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InvoiceTemplate copyWithCompanion(InvoiceTemplatesCompanion data) {
    return InvoiceTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      templateKey: data.templateKey.present
          ? data.templateKey.value
          : this.templateKey,
      description: data.description.present
          ? data.description.value
          : this.description,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      accentColor: data.accentColor.present
          ? data.accentColor.value
          : this.accentColor,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      showLogo: data.showLogo.present ? data.showLogo.value : this.showLogo,
      showPaymentInfo: data.showPaymentInfo.present
          ? data.showPaymentInfo.value
          : this.showPaymentInfo,
      showTaxBreakdown: data.showTaxBreakdown.present
          ? data.showTaxBreakdown.value
          : this.showTaxBreakdown,
      showTaxId: data.showTaxId.present ? data.showTaxId.value : this.showTaxId,
      showBusinessLicense: data.showBusinessLicense.present
          ? data.showBusinessLicense.value
          : this.showBusinessLicense,
      showBankDetails: data.showBankDetails.present
          ? data.showBankDetails.value
          : this.showBankDetails,
      showStripeLink: data.showStripeLink.present
          ? data.showStripeLink.value
          : this.showStripeLink,
      showDetailedBreakdown: data.showDetailedBreakdown.present
          ? data.showDetailedBreakdown.value
          : this.showDetailedBreakdown,
      showPaymentTerms: data.showPaymentTerms.present
          ? data.showPaymentTerms.value
          : this.showPaymentTerms,
      showLateFeeClause: data.showLateFeeClause.present
          ? data.showLateFeeClause.value
          : this.showLateFeeClause,
      footerText: data.footerText.present
          ? data.footerText.value
          : this.footerText,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('templateKey: $templateKey, ')
          ..write('description: $description, ')
          ..write('isDefault: $isDefault, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('accentColor: $accentColor, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('showLogo: $showLogo, ')
          ..write('showPaymentInfo: $showPaymentInfo, ')
          ..write('showTaxBreakdown: $showTaxBreakdown, ')
          ..write('showTaxId: $showTaxId, ')
          ..write('showBusinessLicense: $showBusinessLicense, ')
          ..write('showBankDetails: $showBankDetails, ')
          ..write('showStripeLink: $showStripeLink, ')
          ..write('showDetailedBreakdown: $showDetailedBreakdown, ')
          ..write('showPaymentTerms: $showPaymentTerms, ')
          ..write('showLateFeeClause: $showLateFeeClause, ')
          ..write('footerText: $footerText, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    templateKey,
    description,
    isDefault,
    primaryColor,
    accentColor,
    fontFamily,
    showLogo,
    showPaymentInfo,
    showTaxBreakdown,
    showTaxId,
    showBusinessLicense,
    showBankDetails,
    showStripeLink,
    showDetailedBreakdown,
    showPaymentTerms,
    showLateFeeClause,
    footerText,
    isBuiltIn,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.templateKey == this.templateKey &&
          other.description == this.description &&
          other.isDefault == this.isDefault &&
          other.primaryColor == this.primaryColor &&
          other.accentColor == this.accentColor &&
          other.fontFamily == this.fontFamily &&
          other.showLogo == this.showLogo &&
          other.showPaymentInfo == this.showPaymentInfo &&
          other.showTaxBreakdown == this.showTaxBreakdown &&
          other.showTaxId == this.showTaxId &&
          other.showBusinessLicense == this.showBusinessLicense &&
          other.showBankDetails == this.showBankDetails &&
          other.showStripeLink == this.showStripeLink &&
          other.showDetailedBreakdown == this.showDetailedBreakdown &&
          other.showPaymentTerms == this.showPaymentTerms &&
          other.showLateFeeClause == this.showLateFeeClause &&
          other.footerText == this.footerText &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InvoiceTemplatesCompanion extends UpdateCompanion<InvoiceTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> templateKey;
  final Value<String?> description;
  final Value<bool> isDefault;
  final Value<int> primaryColor;
  final Value<int> accentColor;
  final Value<String> fontFamily;
  final Value<bool> showLogo;
  final Value<bool> showPaymentInfo;
  final Value<bool> showTaxBreakdown;
  final Value<bool> showTaxId;
  final Value<bool> showBusinessLicense;
  final Value<bool> showBankDetails;
  final Value<bool> showStripeLink;
  final Value<bool> showDetailedBreakdown;
  final Value<bool> showPaymentTerms;
  final Value<bool> showLateFeeClause;
  final Value<String?> footerText;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InvoiceTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.templateKey = const Value.absent(),
    this.description = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.showLogo = const Value.absent(),
    this.showPaymentInfo = const Value.absent(),
    this.showTaxBreakdown = const Value.absent(),
    this.showTaxId = const Value.absent(),
    this.showBusinessLicense = const Value.absent(),
    this.showBankDetails = const Value.absent(),
    this.showStripeLink = const Value.absent(),
    this.showDetailedBreakdown = const Value.absent(),
    this.showPaymentTerms = const Value.absent(),
    this.showLateFeeClause = const Value.absent(),
    this.footerText = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InvoiceTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String templateKey,
    this.description = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.showLogo = const Value.absent(),
    this.showPaymentInfo = const Value.absent(),
    this.showTaxBreakdown = const Value.absent(),
    this.showTaxId = const Value.absent(),
    this.showBusinessLicense = const Value.absent(),
    this.showBankDetails = const Value.absent(),
    this.showStripeLink = const Value.absent(),
    this.showDetailedBreakdown = const Value.absent(),
    this.showPaymentTerms = const Value.absent(),
    this.showLateFeeClause = const Value.absent(),
    this.footerText = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       templateKey = Value(templateKey);
  static Insertable<InvoiceTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? templateKey,
    Expression<String>? description,
    Expression<bool>? isDefault,
    Expression<int>? primaryColor,
    Expression<int>? accentColor,
    Expression<String>? fontFamily,
    Expression<bool>? showLogo,
    Expression<bool>? showPaymentInfo,
    Expression<bool>? showTaxBreakdown,
    Expression<bool>? showTaxId,
    Expression<bool>? showBusinessLicense,
    Expression<bool>? showBankDetails,
    Expression<bool>? showStripeLink,
    Expression<bool>? showDetailedBreakdown,
    Expression<bool>? showPaymentTerms,
    Expression<bool>? showLateFeeClause,
    Expression<String>? footerText,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (templateKey != null) 'template_key': templateKey,
      if (description != null) 'description': description,
      if (isDefault != null) 'is_default': isDefault,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (accentColor != null) 'accent_color': accentColor,
      if (fontFamily != null) 'font_family': fontFamily,
      if (showLogo != null) 'show_logo': showLogo,
      if (showPaymentInfo != null) 'show_payment_info': showPaymentInfo,
      if (showTaxBreakdown != null) 'show_tax_breakdown': showTaxBreakdown,
      if (showTaxId != null) 'show_tax_id': showTaxId,
      if (showBusinessLicense != null)
        'show_business_license': showBusinessLicense,
      if (showBankDetails != null) 'show_bank_details': showBankDetails,
      if (showStripeLink != null) 'show_stripe_link': showStripeLink,
      if (showDetailedBreakdown != null)
        'show_detailed_breakdown': showDetailedBreakdown,
      if (showPaymentTerms != null) 'show_payment_terms': showPaymentTerms,
      if (showLateFeeClause != null) 'show_late_fee_clause': showLateFeeClause,
      if (footerText != null) 'footer_text': footerText,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InvoiceTemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? templateKey,
    Value<String?>? description,
    Value<bool>? isDefault,
    Value<int>? primaryColor,
    Value<int>? accentColor,
    Value<String>? fontFamily,
    Value<bool>? showLogo,
    Value<bool>? showPaymentInfo,
    Value<bool>? showTaxBreakdown,
    Value<bool>? showTaxId,
    Value<bool>? showBusinessLicense,
    Value<bool>? showBankDetails,
    Value<bool>? showStripeLink,
    Value<bool>? showDetailedBreakdown,
    Value<bool>? showPaymentTerms,
    Value<bool>? showLateFeeClause,
    Value<String?>? footerText,
    Value<bool>? isBuiltIn,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return InvoiceTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      templateKey: templateKey ?? this.templateKey,
      description: description ?? this.description,
      isDefault: isDefault ?? this.isDefault,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      fontFamily: fontFamily ?? this.fontFamily,
      showLogo: showLogo ?? this.showLogo,
      showPaymentInfo: showPaymentInfo ?? this.showPaymentInfo,
      showTaxBreakdown: showTaxBreakdown ?? this.showTaxBreakdown,
      showTaxId: showTaxId ?? this.showTaxId,
      showBusinessLicense: showBusinessLicense ?? this.showBusinessLicense,
      showBankDetails: showBankDetails ?? this.showBankDetails,
      showStripeLink: showStripeLink ?? this.showStripeLink,
      showDetailedBreakdown:
          showDetailedBreakdown ?? this.showDetailedBreakdown,
      showPaymentTerms: showPaymentTerms ?? this.showPaymentTerms,
      showLateFeeClause: showLateFeeClause ?? this.showLateFeeClause,
      footerText: footerText ?? this.footerText,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (templateKey.present) {
      map['template_key'] = Variable<String>(templateKey.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<int>(primaryColor.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<int>(accentColor.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(fontFamily.value);
    }
    if (showLogo.present) {
      map['show_logo'] = Variable<bool>(showLogo.value);
    }
    if (showPaymentInfo.present) {
      map['show_payment_info'] = Variable<bool>(showPaymentInfo.value);
    }
    if (showTaxBreakdown.present) {
      map['show_tax_breakdown'] = Variable<bool>(showTaxBreakdown.value);
    }
    if (showTaxId.present) {
      map['show_tax_id'] = Variable<bool>(showTaxId.value);
    }
    if (showBusinessLicense.present) {
      map['show_business_license'] = Variable<bool>(showBusinessLicense.value);
    }
    if (showBankDetails.present) {
      map['show_bank_details'] = Variable<bool>(showBankDetails.value);
    }
    if (showStripeLink.present) {
      map['show_stripe_link'] = Variable<bool>(showStripeLink.value);
    }
    if (showDetailedBreakdown.present) {
      map['show_detailed_breakdown'] = Variable<bool>(
        showDetailedBreakdown.value,
      );
    }
    if (showPaymentTerms.present) {
      map['show_payment_terms'] = Variable<bool>(showPaymentTerms.value);
    }
    if (showLateFeeClause.present) {
      map['show_late_fee_clause'] = Variable<bool>(showLateFeeClause.value);
    }
    if (footerText.present) {
      map['footer_text'] = Variable<String>(footerText.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('templateKey: $templateKey, ')
          ..write('description: $description, ')
          ..write('isDefault: $isDefault, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('accentColor: $accentColor, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('showLogo: $showLogo, ')
          ..write('showPaymentInfo: $showPaymentInfo, ')
          ..write('showTaxBreakdown: $showTaxBreakdown, ')
          ..write('showTaxId: $showTaxId, ')
          ..write('showBusinessLicense: $showBusinessLicense, ')
          ..write('showBankDetails: $showBankDetails, ')
          ..write('showStripeLink: $showStripeLink, ')
          ..write('showDetailedBreakdown: $showDetailedBreakdown, ')
          ..write('showPaymentTerms: $showPaymentTerms, ')
          ..write('showLateFeeClause: $showLateFeeClause, ')
          ..write('footerText: $footerText, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _businessNameMeta = const VerificationMeta(
    'businessName',
  );
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
    'business_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressLine1Meta = const VerificationMeta(
    'addressLine1',
  );
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
    'address_line1',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressLine2Meta = const VerificationMeta(
    'addressLine2',
  );
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
    'address_line2',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateProvinceMeta = const VerificationMeta(
    'stateProvince',
  );
  @override
  late final GeneratedColumn<String> stateProvince = GeneratedColumn<String>(
    'state_province',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  @override
  late final GeneratedColumn<String> taxId = GeneratedColumn<String>(
    'tax_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _showTaxIdMeta = const VerificationMeta(
    'showTaxId',
  );
  @override
  late final GeneratedColumn<bool> showTaxId = GeneratedColumn<bool>(
    'show_tax_id',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_tax_id" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _waBusinessLicenseMeta = const VerificationMeta(
    'waBusinessLicense',
  );
  @override
  late final GeneratedColumn<String> waBusinessLicense =
      GeneratedColumn<String>(
        'wa_business_license',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _showWaLicenseMeta = const VerificationMeta(
    'showWaLicense',
  );
  @override
  late final GeneratedColumn<bool> showWaLicense = GeneratedColumn<bool>(
    'show_wa_license',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_wa_license" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankAccountNameMeta = const VerificationMeta(
    'bankAccountName',
  );
  @override
  late final GeneratedColumn<String> bankAccountName = GeneratedColumn<String>(
    'bank_account_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankAccountNumberMeta = const VerificationMeta(
    'bankAccountNumber',
  );
  @override
  late final GeneratedColumn<String> bankAccountNumber =
      GeneratedColumn<String>(
        'bank_account_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _bankRoutingNumberMeta = const VerificationMeta(
    'bankRoutingNumber',
  );
  @override
  late final GeneratedColumn<String> bankRoutingNumber =
      GeneratedColumn<String>(
        'bank_routing_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _bankAccountTypeMeta = const VerificationMeta(
    'bankAccountType',
  );
  @override
  late final GeneratedColumn<String> bankAccountType = GeneratedColumn<String>(
    'bank_account_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('checking'),
  );
  static const VerificationMeta _bankSwiftMeta = const VerificationMeta(
    'bankSwift',
  );
  @override
  late final GeneratedColumn<String> bankSwift = GeneratedColumn<String>(
    'bank_swift',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankIbanMeta = const VerificationMeta(
    'bankIban',
  );
  @override
  late final GeneratedColumn<String> bankIban = GeneratedColumn<String>(
    'bank_iban',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _showBankDetailsMeta = const VerificationMeta(
    'showBankDetails',
  );
  @override
  late final GeneratedColumn<bool> showBankDetails = GeneratedColumn<bool>(
    'show_bank_details',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_bank_details" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _stripePaymentLinkMeta = const VerificationMeta(
    'stripePaymentLink',
  );
  @override
  late final GeneratedColumn<String> stripePaymentLink =
      GeneratedColumn<String>(
        'stripe_payment_link',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _showStripeLinkMeta = const VerificationMeta(
    'showStripeLink',
  );
  @override
  late final GeneratedColumn<bool> showStripeLink = GeneratedColumn<bool>(
    'show_stripe_link',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_stripe_link" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _paymentInstructionsMeta =
      const VerificationMeta('paymentInstructions');
  @override
  late final GeneratedColumn<String> paymentInstructions =
      GeneratedColumn<String>(
        'payment_instructions',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _defaultHourlyRateMeta = const VerificationMeta(
    'defaultHourlyRate',
  );
  @override
  late final GeneratedColumn<double> defaultHourlyRate =
      GeneratedColumn<double>(
        'default_hourly_rate',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _defaultTaxLabelMeta = const VerificationMeta(
    'defaultTaxLabel',
  );
  @override
  late final GeneratedColumn<String> defaultTaxLabel = GeneratedColumn<String>(
    'default_tax_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Tax'),
  );
  static const VerificationMeta _defaultTaxRateMeta = const VerificationMeta(
    'defaultTaxRate',
  );
  @override
  late final GeneratedColumn<double> defaultTaxRate = GeneratedColumn<double>(
    'default_tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _defaultPaymentTermsMeta =
      const VerificationMeta('defaultPaymentTerms');
  @override
  late final GeneratedColumn<String> defaultPaymentTerms =
      GeneratedColumn<String>(
        'default_payment_terms',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('net_30'),
      );
  static const VerificationMeta _defaultPaymentTermsDaysMeta =
      const VerificationMeta('defaultPaymentTermsDays');
  @override
  late final GeneratedColumn<int> defaultPaymentTermsDays =
      GeneratedColumn<int>(
        'default_payment_terms_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(30),
      );
  static const VerificationMeta _lateFeePercentageMeta = const VerificationMeta(
    'lateFeePercentage',
  );
  @override
  late final GeneratedColumn<double> lateFeePercentage =
      GeneratedColumn<double>(
        'late_fee_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultTemplateIdMeta = const VerificationMeta(
    'defaultTemplateId',
  );
  @override
  late final GeneratedColumn<int> defaultTemplateId = GeneratedColumn<int>(
    'default_template_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoice_templates (id)',
    ),
  );
  static const VerificationMeta _defaultEmailSubjectFormatMeta =
      const VerificationMeta('defaultEmailSubjectFormat');
  @override
  late final GeneratedColumn<String> defaultEmailSubjectFormat =
      GeneratedColumn<String>(
        'default_email_subject_format',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('Invoice #{number} – {period}'),
      );
  static const VerificationMeta _nextInvoiceNumberMeta = const VerificationMeta(
    'nextInvoiceNumber',
  );
  @override
  late final GeneratedColumn<int> nextInvoiceNumber = GeneratedColumn<int>(
    'next_invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _invoiceNumberPrefixMeta =
      const VerificationMeta('invoiceNumberPrefix');
  @override
  late final GeneratedColumn<String> invoiceNumberPrefix =
      GeneratedColumn<String>(
        'invoice_number_prefix',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('INV-'),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessName,
    ownerName,
    email,
    phone,
    addressLine1,
    addressLine2,
    city,
    stateProvince,
    postalCode,
    country,
    taxId,
    showTaxId,
    waBusinessLicense,
    showWaLicense,
    logoPath,
    bankName,
    bankAccountName,
    bankAccountNumber,
    bankRoutingNumber,
    bankAccountType,
    bankSwift,
    bankIban,
    showBankDetails,
    stripePaymentLink,
    showStripeLink,
    paymentInstructions,
    defaultCurrency,
    defaultHourlyRate,
    defaultTaxLabel,
    defaultTaxRate,
    defaultPaymentTerms,
    defaultPaymentTermsDays,
    lateFeePercentage,
    defaultTemplateId,
    defaultEmailSubjectFormat,
    nextInvoiceNumber,
    invoiceNumberPrefix,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('business_name')) {
      context.handle(
        _businessNameMeta,
        businessName.isAcceptableOrUnknown(
          data['business_name']!,
          _businessNameMeta,
        ),
      );
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address_line1')) {
      context.handle(
        _addressLine1Meta,
        addressLine1.isAcceptableOrUnknown(
          data['address_line1']!,
          _addressLine1Meta,
        ),
      );
    }
    if (data.containsKey('address_line2')) {
      context.handle(
        _addressLine2Meta,
        addressLine2.isAcceptableOrUnknown(
          data['address_line2']!,
          _addressLine2Meta,
        ),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('state_province')) {
      context.handle(
        _stateProvinceMeta,
        stateProvince.isAcceptableOrUnknown(
          data['state_province']!,
          _stateProvinceMeta,
        ),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('tax_id')) {
      context.handle(
        _taxIdMeta,
        taxId.isAcceptableOrUnknown(data['tax_id']!, _taxIdMeta),
      );
    }
    if (data.containsKey('show_tax_id')) {
      context.handle(
        _showTaxIdMeta,
        showTaxId.isAcceptableOrUnknown(data['show_tax_id']!, _showTaxIdMeta),
      );
    }
    if (data.containsKey('wa_business_license')) {
      context.handle(
        _waBusinessLicenseMeta,
        waBusinessLicense.isAcceptableOrUnknown(
          data['wa_business_license']!,
          _waBusinessLicenseMeta,
        ),
      );
    }
    if (data.containsKey('show_wa_license')) {
      context.handle(
        _showWaLicenseMeta,
        showWaLicense.isAcceptableOrUnknown(
          data['show_wa_license']!,
          _showWaLicenseMeta,
        ),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    }
    if (data.containsKey('bank_account_name')) {
      context.handle(
        _bankAccountNameMeta,
        bankAccountName.isAcceptableOrUnknown(
          data['bank_account_name']!,
          _bankAccountNameMeta,
        ),
      );
    }
    if (data.containsKey('bank_account_number')) {
      context.handle(
        _bankAccountNumberMeta,
        bankAccountNumber.isAcceptableOrUnknown(
          data['bank_account_number']!,
          _bankAccountNumberMeta,
        ),
      );
    }
    if (data.containsKey('bank_routing_number')) {
      context.handle(
        _bankRoutingNumberMeta,
        bankRoutingNumber.isAcceptableOrUnknown(
          data['bank_routing_number']!,
          _bankRoutingNumberMeta,
        ),
      );
    }
    if (data.containsKey('bank_account_type')) {
      context.handle(
        _bankAccountTypeMeta,
        bankAccountType.isAcceptableOrUnknown(
          data['bank_account_type']!,
          _bankAccountTypeMeta,
        ),
      );
    }
    if (data.containsKey('bank_swift')) {
      context.handle(
        _bankSwiftMeta,
        bankSwift.isAcceptableOrUnknown(data['bank_swift']!, _bankSwiftMeta),
      );
    }
    if (data.containsKey('bank_iban')) {
      context.handle(
        _bankIbanMeta,
        bankIban.isAcceptableOrUnknown(data['bank_iban']!, _bankIbanMeta),
      );
    }
    if (data.containsKey('show_bank_details')) {
      context.handle(
        _showBankDetailsMeta,
        showBankDetails.isAcceptableOrUnknown(
          data['show_bank_details']!,
          _showBankDetailsMeta,
        ),
      );
    }
    if (data.containsKey('stripe_payment_link')) {
      context.handle(
        _stripePaymentLinkMeta,
        stripePaymentLink.isAcceptableOrUnknown(
          data['stripe_payment_link']!,
          _stripePaymentLinkMeta,
        ),
      );
    }
    if (data.containsKey('show_stripe_link')) {
      context.handle(
        _showStripeLinkMeta,
        showStripeLink.isAcceptableOrUnknown(
          data['show_stripe_link']!,
          _showStripeLinkMeta,
        ),
      );
    }
    if (data.containsKey('payment_instructions')) {
      context.handle(
        _paymentInstructionsMeta,
        paymentInstructions.isAcceptableOrUnknown(
          data['payment_instructions']!,
          _paymentInstructionsMeta,
        ),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('default_hourly_rate')) {
      context.handle(
        _defaultHourlyRateMeta,
        defaultHourlyRate.isAcceptableOrUnknown(
          data['default_hourly_rate']!,
          _defaultHourlyRateMeta,
        ),
      );
    }
    if (data.containsKey('default_tax_label')) {
      context.handle(
        _defaultTaxLabelMeta,
        defaultTaxLabel.isAcceptableOrUnknown(
          data['default_tax_label']!,
          _defaultTaxLabelMeta,
        ),
      );
    }
    if (data.containsKey('default_tax_rate')) {
      context.handle(
        _defaultTaxRateMeta,
        defaultTaxRate.isAcceptableOrUnknown(
          data['default_tax_rate']!,
          _defaultTaxRateMeta,
        ),
      );
    }
    if (data.containsKey('default_payment_terms')) {
      context.handle(
        _defaultPaymentTermsMeta,
        defaultPaymentTerms.isAcceptableOrUnknown(
          data['default_payment_terms']!,
          _defaultPaymentTermsMeta,
        ),
      );
    }
    if (data.containsKey('default_payment_terms_days')) {
      context.handle(
        _defaultPaymentTermsDaysMeta,
        defaultPaymentTermsDays.isAcceptableOrUnknown(
          data['default_payment_terms_days']!,
          _defaultPaymentTermsDaysMeta,
        ),
      );
    }
    if (data.containsKey('late_fee_percentage')) {
      context.handle(
        _lateFeePercentageMeta,
        lateFeePercentage.isAcceptableOrUnknown(
          data['late_fee_percentage']!,
          _lateFeePercentageMeta,
        ),
      );
    }
    if (data.containsKey('default_template_id')) {
      context.handle(
        _defaultTemplateIdMeta,
        defaultTemplateId.isAcceptableOrUnknown(
          data['default_template_id']!,
          _defaultTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('default_email_subject_format')) {
      context.handle(
        _defaultEmailSubjectFormatMeta,
        defaultEmailSubjectFormat.isAcceptableOrUnknown(
          data['default_email_subject_format']!,
          _defaultEmailSubjectFormatMeta,
        ),
      );
    }
    if (data.containsKey('next_invoice_number')) {
      context.handle(
        _nextInvoiceNumberMeta,
        nextInvoiceNumber.isAcceptableOrUnknown(
          data['next_invoice_number']!,
          _nextInvoiceNumberMeta,
        ),
      );
    }
    if (data.containsKey('invoice_number_prefix')) {
      context.handle(
        _invoiceNumberPrefixMeta,
        invoiceNumberPrefix.isAcceptableOrUnknown(
          data['invoice_number_prefix']!,
          _invoiceNumberPrefixMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      businessName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_name'],
      )!,
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      addressLine1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line1'],
      ),
      addressLine2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line2'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      stateProvince: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_province'],
      ),
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      taxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_id'],
      ),
      showTaxId: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_tax_id'],
      )!,
      waBusinessLicense: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wa_business_license'],
      ),
      showWaLicense: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_wa_license'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      ),
      bankAccountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_name'],
      ),
      bankAccountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_number'],
      ),
      bankRoutingNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_routing_number'],
      ),
      bankAccountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_type'],
      )!,
      bankSwift: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_swift'],
      ),
      bankIban: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_iban'],
      ),
      showBankDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_bank_details'],
      )!,
      stripePaymentLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stripe_payment_link'],
      ),
      showStripeLink: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_stripe_link'],
      )!,
      paymentInstructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_instructions'],
      ),
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      defaultHourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_hourly_rate'],
      )!,
      defaultTaxLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_tax_label'],
      )!,
      defaultTaxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_tax_rate'],
      )!,
      defaultPaymentTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_payment_terms'],
      )!,
      defaultPaymentTermsDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_payment_terms_days'],
      )!,
      lateFeePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}late_fee_percentage'],
      ),
      defaultTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_template_id'],
      ),
      defaultEmailSubjectFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_email_subject_format'],
      )!,
      nextInvoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_invoice_number'],
      )!,
      invoiceNumberPrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number_prefix'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String businessName;
  final String ownerName;
  final String? email;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? stateProvince;
  final String? postalCode;
  final String? country;
  final String? taxId;
  final bool showTaxId;
  final String? waBusinessLicense;
  final bool showWaLicense;
  final String? logoPath;
  final String? bankName;
  final String? bankAccountName;
  final String? bankAccountNumber;
  final String? bankRoutingNumber;
  final String bankAccountType;
  final String? bankSwift;
  final String? bankIban;
  final bool showBankDetails;
  final String? stripePaymentLink;
  final bool showStripeLink;
  final String? paymentInstructions;
  final String defaultCurrency;
  final double defaultHourlyRate;
  final String defaultTaxLabel;
  final double defaultTaxRate;
  final String defaultPaymentTerms;
  final int defaultPaymentTermsDays;
  final double? lateFeePercentage;
  final int? defaultTemplateId;
  final String defaultEmailSubjectFormat;
  final int nextInvoiceNumber;
  final String invoiceNumberPrefix;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfile({
    required this.id,
    required this.businessName,
    required this.ownerName,
    this.email,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    this.taxId,
    required this.showTaxId,
    this.waBusinessLicense,
    required this.showWaLicense,
    this.logoPath,
    this.bankName,
    this.bankAccountName,
    this.bankAccountNumber,
    this.bankRoutingNumber,
    required this.bankAccountType,
    this.bankSwift,
    this.bankIban,
    required this.showBankDetails,
    this.stripePaymentLink,
    required this.showStripeLink,
    this.paymentInstructions,
    required this.defaultCurrency,
    required this.defaultHourlyRate,
    required this.defaultTaxLabel,
    required this.defaultTaxRate,
    required this.defaultPaymentTerms,
    required this.defaultPaymentTermsDays,
    this.lateFeePercentage,
    this.defaultTemplateId,
    required this.defaultEmailSubjectFormat,
    required this.nextInvoiceNumber,
    required this.invoiceNumberPrefix,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['business_name'] = Variable<String>(businessName);
    map['owner_name'] = Variable<String>(ownerName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || addressLine1 != null) {
      map['address_line1'] = Variable<String>(addressLine1);
    }
    if (!nullToAbsent || addressLine2 != null) {
      map['address_line2'] = Variable<String>(addressLine2);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || stateProvince != null) {
      map['state_province'] = Variable<String>(stateProvince);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<String>(taxId);
    }
    map['show_tax_id'] = Variable<bool>(showTaxId);
    if (!nullToAbsent || waBusinessLicense != null) {
      map['wa_business_license'] = Variable<String>(waBusinessLicense);
    }
    map['show_wa_license'] = Variable<bool>(showWaLicense);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || bankAccountName != null) {
      map['bank_account_name'] = Variable<String>(bankAccountName);
    }
    if (!nullToAbsent || bankAccountNumber != null) {
      map['bank_account_number'] = Variable<String>(bankAccountNumber);
    }
    if (!nullToAbsent || bankRoutingNumber != null) {
      map['bank_routing_number'] = Variable<String>(bankRoutingNumber);
    }
    map['bank_account_type'] = Variable<String>(bankAccountType);
    if (!nullToAbsent || bankSwift != null) {
      map['bank_swift'] = Variable<String>(bankSwift);
    }
    if (!nullToAbsent || bankIban != null) {
      map['bank_iban'] = Variable<String>(bankIban);
    }
    map['show_bank_details'] = Variable<bool>(showBankDetails);
    if (!nullToAbsent || stripePaymentLink != null) {
      map['stripe_payment_link'] = Variable<String>(stripePaymentLink);
    }
    map['show_stripe_link'] = Variable<bool>(showStripeLink);
    if (!nullToAbsent || paymentInstructions != null) {
      map['payment_instructions'] = Variable<String>(paymentInstructions);
    }
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['default_hourly_rate'] = Variable<double>(defaultHourlyRate);
    map['default_tax_label'] = Variable<String>(defaultTaxLabel);
    map['default_tax_rate'] = Variable<double>(defaultTaxRate);
    map['default_payment_terms'] = Variable<String>(defaultPaymentTerms);
    map['default_payment_terms_days'] = Variable<int>(defaultPaymentTermsDays);
    if (!nullToAbsent || lateFeePercentage != null) {
      map['late_fee_percentage'] = Variable<double>(lateFeePercentage);
    }
    if (!nullToAbsent || defaultTemplateId != null) {
      map['default_template_id'] = Variable<int>(defaultTemplateId);
    }
    map['default_email_subject_format'] = Variable<String>(
      defaultEmailSubjectFormat,
    );
    map['next_invoice_number'] = Variable<int>(nextInvoiceNumber);
    map['invoice_number_prefix'] = Variable<String>(invoiceNumberPrefix);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      businessName: Value(businessName),
      ownerName: Value(ownerName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      addressLine1: addressLine1 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine1),
      addressLine2: addressLine2 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine2),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      stateProvince: stateProvince == null && nullToAbsent
          ? const Value.absent()
          : Value(stateProvince),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      taxId: taxId == null && nullToAbsent
          ? const Value.absent()
          : Value(taxId),
      showTaxId: Value(showTaxId),
      waBusinessLicense: waBusinessLicense == null && nullToAbsent
          ? const Value.absent()
          : Value(waBusinessLicense),
      showWaLicense: Value(showWaLicense),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      bankAccountName: bankAccountName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankAccountName),
      bankAccountNumber: bankAccountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(bankAccountNumber),
      bankRoutingNumber: bankRoutingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(bankRoutingNumber),
      bankAccountType: Value(bankAccountType),
      bankSwift: bankSwift == null && nullToAbsent
          ? const Value.absent()
          : Value(bankSwift),
      bankIban: bankIban == null && nullToAbsent
          ? const Value.absent()
          : Value(bankIban),
      showBankDetails: Value(showBankDetails),
      stripePaymentLink: stripePaymentLink == null && nullToAbsent
          ? const Value.absent()
          : Value(stripePaymentLink),
      showStripeLink: Value(showStripeLink),
      paymentInstructions: paymentInstructions == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentInstructions),
      defaultCurrency: Value(defaultCurrency),
      defaultHourlyRate: Value(defaultHourlyRate),
      defaultTaxLabel: Value(defaultTaxLabel),
      defaultTaxRate: Value(defaultTaxRate),
      defaultPaymentTerms: Value(defaultPaymentTerms),
      defaultPaymentTermsDays: Value(defaultPaymentTermsDays),
      lateFeePercentage: lateFeePercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(lateFeePercentage),
      defaultTemplateId: defaultTemplateId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultTemplateId),
      defaultEmailSubjectFormat: Value(defaultEmailSubjectFormat),
      nextInvoiceNumber: Value(nextInvoiceNumber),
      invoiceNumberPrefix: Value(invoiceNumberPrefix),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      businessName: serializer.fromJson<String>(json['businessName']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      addressLine1: serializer.fromJson<String?>(json['addressLine1']),
      addressLine2: serializer.fromJson<String?>(json['addressLine2']),
      city: serializer.fromJson<String?>(json['city']),
      stateProvince: serializer.fromJson<String?>(json['stateProvince']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      country: serializer.fromJson<String?>(json['country']),
      taxId: serializer.fromJson<String?>(json['taxId']),
      showTaxId: serializer.fromJson<bool>(json['showTaxId']),
      waBusinessLicense: serializer.fromJson<String?>(
        json['waBusinessLicense'],
      ),
      showWaLicense: serializer.fromJson<bool>(json['showWaLicense']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      bankAccountName: serializer.fromJson<String?>(json['bankAccountName']),
      bankAccountNumber: serializer.fromJson<String?>(
        json['bankAccountNumber'],
      ),
      bankRoutingNumber: serializer.fromJson<String?>(
        json['bankRoutingNumber'],
      ),
      bankAccountType: serializer.fromJson<String>(json['bankAccountType']),
      bankSwift: serializer.fromJson<String?>(json['bankSwift']),
      bankIban: serializer.fromJson<String?>(json['bankIban']),
      showBankDetails: serializer.fromJson<bool>(json['showBankDetails']),
      stripePaymentLink: serializer.fromJson<String?>(
        json['stripePaymentLink'],
      ),
      showStripeLink: serializer.fromJson<bool>(json['showStripeLink']),
      paymentInstructions: serializer.fromJson<String?>(
        json['paymentInstructions'],
      ),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      defaultHourlyRate: serializer.fromJson<double>(json['defaultHourlyRate']),
      defaultTaxLabel: serializer.fromJson<String>(json['defaultTaxLabel']),
      defaultTaxRate: serializer.fromJson<double>(json['defaultTaxRate']),
      defaultPaymentTerms: serializer.fromJson<String>(
        json['defaultPaymentTerms'],
      ),
      defaultPaymentTermsDays: serializer.fromJson<int>(
        json['defaultPaymentTermsDays'],
      ),
      lateFeePercentage: serializer.fromJson<double?>(
        json['lateFeePercentage'],
      ),
      defaultTemplateId: serializer.fromJson<int?>(json['defaultTemplateId']),
      defaultEmailSubjectFormat: serializer.fromJson<String>(
        json['defaultEmailSubjectFormat'],
      ),
      nextInvoiceNumber: serializer.fromJson<int>(json['nextInvoiceNumber']),
      invoiceNumberPrefix: serializer.fromJson<String>(
        json['invoiceNumberPrefix'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'businessName': serializer.toJson<String>(businessName),
      'ownerName': serializer.toJson<String>(ownerName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'addressLine1': serializer.toJson<String?>(addressLine1),
      'addressLine2': serializer.toJson<String?>(addressLine2),
      'city': serializer.toJson<String?>(city),
      'stateProvince': serializer.toJson<String?>(stateProvince),
      'postalCode': serializer.toJson<String?>(postalCode),
      'country': serializer.toJson<String?>(country),
      'taxId': serializer.toJson<String?>(taxId),
      'showTaxId': serializer.toJson<bool>(showTaxId),
      'waBusinessLicense': serializer.toJson<String?>(waBusinessLicense),
      'showWaLicense': serializer.toJson<bool>(showWaLicense),
      'logoPath': serializer.toJson<String?>(logoPath),
      'bankName': serializer.toJson<String?>(bankName),
      'bankAccountName': serializer.toJson<String?>(bankAccountName),
      'bankAccountNumber': serializer.toJson<String?>(bankAccountNumber),
      'bankRoutingNumber': serializer.toJson<String?>(bankRoutingNumber),
      'bankAccountType': serializer.toJson<String>(bankAccountType),
      'bankSwift': serializer.toJson<String?>(bankSwift),
      'bankIban': serializer.toJson<String?>(bankIban),
      'showBankDetails': serializer.toJson<bool>(showBankDetails),
      'stripePaymentLink': serializer.toJson<String?>(stripePaymentLink),
      'showStripeLink': serializer.toJson<bool>(showStripeLink),
      'paymentInstructions': serializer.toJson<String?>(paymentInstructions),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'defaultHourlyRate': serializer.toJson<double>(defaultHourlyRate),
      'defaultTaxLabel': serializer.toJson<String>(defaultTaxLabel),
      'defaultTaxRate': serializer.toJson<double>(defaultTaxRate),
      'defaultPaymentTerms': serializer.toJson<String>(defaultPaymentTerms),
      'defaultPaymentTermsDays': serializer.toJson<int>(
        defaultPaymentTermsDays,
      ),
      'lateFeePercentage': serializer.toJson<double?>(lateFeePercentage),
      'defaultTemplateId': serializer.toJson<int?>(defaultTemplateId),
      'defaultEmailSubjectFormat': serializer.toJson<String>(
        defaultEmailSubjectFormat,
      ),
      'nextInvoiceNumber': serializer.toJson<int>(nextInvoiceNumber),
      'invoiceNumberPrefix': serializer.toJson<String>(invoiceNumberPrefix),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith({
    int? id,
    String? businessName,
    String? ownerName,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> addressLine1 = const Value.absent(),
    Value<String?> addressLine2 = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> stateProvince = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> taxId = const Value.absent(),
    bool? showTaxId,
    Value<String?> waBusinessLicense = const Value.absent(),
    bool? showWaLicense,
    Value<String?> logoPath = const Value.absent(),
    Value<String?> bankName = const Value.absent(),
    Value<String?> bankAccountName = const Value.absent(),
    Value<String?> bankAccountNumber = const Value.absent(),
    Value<String?> bankRoutingNumber = const Value.absent(),
    String? bankAccountType,
    Value<String?> bankSwift = const Value.absent(),
    Value<String?> bankIban = const Value.absent(),
    bool? showBankDetails,
    Value<String?> stripePaymentLink = const Value.absent(),
    bool? showStripeLink,
    Value<String?> paymentInstructions = const Value.absent(),
    String? defaultCurrency,
    double? defaultHourlyRate,
    String? defaultTaxLabel,
    double? defaultTaxRate,
    String? defaultPaymentTerms,
    int? defaultPaymentTermsDays,
    Value<double?> lateFeePercentage = const Value.absent(),
    Value<int?> defaultTemplateId = const Value.absent(),
    String? defaultEmailSubjectFormat,
    int? nextInvoiceNumber,
    String? invoiceNumberPrefix,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProfile(
    id: id ?? this.id,
    businessName: businessName ?? this.businessName,
    ownerName: ownerName ?? this.ownerName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    addressLine1: addressLine1.present ? addressLine1.value : this.addressLine1,
    addressLine2: addressLine2.present ? addressLine2.value : this.addressLine2,
    city: city.present ? city.value : this.city,
    stateProvince: stateProvince.present
        ? stateProvince.value
        : this.stateProvince,
    postalCode: postalCode.present ? postalCode.value : this.postalCode,
    country: country.present ? country.value : this.country,
    taxId: taxId.present ? taxId.value : this.taxId,
    showTaxId: showTaxId ?? this.showTaxId,
    waBusinessLicense: waBusinessLicense.present
        ? waBusinessLicense.value
        : this.waBusinessLicense,
    showWaLicense: showWaLicense ?? this.showWaLicense,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    bankName: bankName.present ? bankName.value : this.bankName,
    bankAccountName: bankAccountName.present
        ? bankAccountName.value
        : this.bankAccountName,
    bankAccountNumber: bankAccountNumber.present
        ? bankAccountNumber.value
        : this.bankAccountNumber,
    bankRoutingNumber: bankRoutingNumber.present
        ? bankRoutingNumber.value
        : this.bankRoutingNumber,
    bankAccountType: bankAccountType ?? this.bankAccountType,
    bankSwift: bankSwift.present ? bankSwift.value : this.bankSwift,
    bankIban: bankIban.present ? bankIban.value : this.bankIban,
    showBankDetails: showBankDetails ?? this.showBankDetails,
    stripePaymentLink: stripePaymentLink.present
        ? stripePaymentLink.value
        : this.stripePaymentLink,
    showStripeLink: showStripeLink ?? this.showStripeLink,
    paymentInstructions: paymentInstructions.present
        ? paymentInstructions.value
        : this.paymentInstructions,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    defaultHourlyRate: defaultHourlyRate ?? this.defaultHourlyRate,
    defaultTaxLabel: defaultTaxLabel ?? this.defaultTaxLabel,
    defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
    defaultPaymentTerms: defaultPaymentTerms ?? this.defaultPaymentTerms,
    defaultPaymentTermsDays:
        defaultPaymentTermsDays ?? this.defaultPaymentTermsDays,
    lateFeePercentage: lateFeePercentage.present
        ? lateFeePercentage.value
        : this.lateFeePercentage,
    defaultTemplateId: defaultTemplateId.present
        ? defaultTemplateId.value
        : this.defaultTemplateId,
    defaultEmailSubjectFormat:
        defaultEmailSubjectFormat ?? this.defaultEmailSubjectFormat,
    nextInvoiceNumber: nextInvoiceNumber ?? this.nextInvoiceNumber,
    invoiceNumberPrefix: invoiceNumberPrefix ?? this.invoiceNumberPrefix,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      city: data.city.present ? data.city.value : this.city,
      stateProvince: data.stateProvince.present
          ? data.stateProvince.value
          : this.stateProvince,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      country: data.country.present ? data.country.value : this.country,
      taxId: data.taxId.present ? data.taxId.value : this.taxId,
      showTaxId: data.showTaxId.present ? data.showTaxId.value : this.showTaxId,
      waBusinessLicense: data.waBusinessLicense.present
          ? data.waBusinessLicense.value
          : this.waBusinessLicense,
      showWaLicense: data.showWaLicense.present
          ? data.showWaLicense.value
          : this.showWaLicense,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      bankAccountName: data.bankAccountName.present
          ? data.bankAccountName.value
          : this.bankAccountName,
      bankAccountNumber: data.bankAccountNumber.present
          ? data.bankAccountNumber.value
          : this.bankAccountNumber,
      bankRoutingNumber: data.bankRoutingNumber.present
          ? data.bankRoutingNumber.value
          : this.bankRoutingNumber,
      bankAccountType: data.bankAccountType.present
          ? data.bankAccountType.value
          : this.bankAccountType,
      bankSwift: data.bankSwift.present ? data.bankSwift.value : this.bankSwift,
      bankIban: data.bankIban.present ? data.bankIban.value : this.bankIban,
      showBankDetails: data.showBankDetails.present
          ? data.showBankDetails.value
          : this.showBankDetails,
      stripePaymentLink: data.stripePaymentLink.present
          ? data.stripePaymentLink.value
          : this.stripePaymentLink,
      showStripeLink: data.showStripeLink.present
          ? data.showStripeLink.value
          : this.showStripeLink,
      paymentInstructions: data.paymentInstructions.present
          ? data.paymentInstructions.value
          : this.paymentInstructions,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      defaultHourlyRate: data.defaultHourlyRate.present
          ? data.defaultHourlyRate.value
          : this.defaultHourlyRate,
      defaultTaxLabel: data.defaultTaxLabel.present
          ? data.defaultTaxLabel.value
          : this.defaultTaxLabel,
      defaultTaxRate: data.defaultTaxRate.present
          ? data.defaultTaxRate.value
          : this.defaultTaxRate,
      defaultPaymentTerms: data.defaultPaymentTerms.present
          ? data.defaultPaymentTerms.value
          : this.defaultPaymentTerms,
      defaultPaymentTermsDays: data.defaultPaymentTermsDays.present
          ? data.defaultPaymentTermsDays.value
          : this.defaultPaymentTermsDays,
      lateFeePercentage: data.lateFeePercentage.present
          ? data.lateFeePercentage.value
          : this.lateFeePercentage,
      defaultTemplateId: data.defaultTemplateId.present
          ? data.defaultTemplateId.value
          : this.defaultTemplateId,
      defaultEmailSubjectFormat: data.defaultEmailSubjectFormat.present
          ? data.defaultEmailSubjectFormat.value
          : this.defaultEmailSubjectFormat,
      nextInvoiceNumber: data.nextInvoiceNumber.present
          ? data.nextInvoiceNumber.value
          : this.nextInvoiceNumber,
      invoiceNumberPrefix: data.invoiceNumberPrefix.present
          ? data.invoiceNumberPrefix.value
          : this.invoiceNumberPrefix,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('ownerName: $ownerName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('postalCode: $postalCode, ')
          ..write('country: $country, ')
          ..write('taxId: $taxId, ')
          ..write('showTaxId: $showTaxId, ')
          ..write('waBusinessLicense: $waBusinessLicense, ')
          ..write('showWaLicense: $showWaLicense, ')
          ..write('logoPath: $logoPath, ')
          ..write('bankName: $bankName, ')
          ..write('bankAccountName: $bankAccountName, ')
          ..write('bankAccountNumber: $bankAccountNumber, ')
          ..write('bankRoutingNumber: $bankRoutingNumber, ')
          ..write('bankAccountType: $bankAccountType, ')
          ..write('bankSwift: $bankSwift, ')
          ..write('bankIban: $bankIban, ')
          ..write('showBankDetails: $showBankDetails, ')
          ..write('stripePaymentLink: $stripePaymentLink, ')
          ..write('showStripeLink: $showStripeLink, ')
          ..write('paymentInstructions: $paymentInstructions, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('defaultHourlyRate: $defaultHourlyRate, ')
          ..write('defaultTaxLabel: $defaultTaxLabel, ')
          ..write('defaultTaxRate: $defaultTaxRate, ')
          ..write('defaultPaymentTerms: $defaultPaymentTerms, ')
          ..write('defaultPaymentTermsDays: $defaultPaymentTermsDays, ')
          ..write('lateFeePercentage: $lateFeePercentage, ')
          ..write('defaultTemplateId: $defaultTemplateId, ')
          ..write('defaultEmailSubjectFormat: $defaultEmailSubjectFormat, ')
          ..write('nextInvoiceNumber: $nextInvoiceNumber, ')
          ..write('invoiceNumberPrefix: $invoiceNumberPrefix, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    businessName,
    ownerName,
    email,
    phone,
    addressLine1,
    addressLine2,
    city,
    stateProvince,
    postalCode,
    country,
    taxId,
    showTaxId,
    waBusinessLicense,
    showWaLicense,
    logoPath,
    bankName,
    bankAccountName,
    bankAccountNumber,
    bankRoutingNumber,
    bankAccountType,
    bankSwift,
    bankIban,
    showBankDetails,
    stripePaymentLink,
    showStripeLink,
    paymentInstructions,
    defaultCurrency,
    defaultHourlyRate,
    defaultTaxLabel,
    defaultTaxRate,
    defaultPaymentTerms,
    defaultPaymentTermsDays,
    lateFeePercentage,
    defaultTemplateId,
    defaultEmailSubjectFormat,
    nextInvoiceNumber,
    invoiceNumberPrefix,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.businessName == this.businessName &&
          other.ownerName == this.ownerName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.city == this.city &&
          other.stateProvince == this.stateProvince &&
          other.postalCode == this.postalCode &&
          other.country == this.country &&
          other.taxId == this.taxId &&
          other.showTaxId == this.showTaxId &&
          other.waBusinessLicense == this.waBusinessLicense &&
          other.showWaLicense == this.showWaLicense &&
          other.logoPath == this.logoPath &&
          other.bankName == this.bankName &&
          other.bankAccountName == this.bankAccountName &&
          other.bankAccountNumber == this.bankAccountNumber &&
          other.bankRoutingNumber == this.bankRoutingNumber &&
          other.bankAccountType == this.bankAccountType &&
          other.bankSwift == this.bankSwift &&
          other.bankIban == this.bankIban &&
          other.showBankDetails == this.showBankDetails &&
          other.stripePaymentLink == this.stripePaymentLink &&
          other.showStripeLink == this.showStripeLink &&
          other.paymentInstructions == this.paymentInstructions &&
          other.defaultCurrency == this.defaultCurrency &&
          other.defaultHourlyRate == this.defaultHourlyRate &&
          other.defaultTaxLabel == this.defaultTaxLabel &&
          other.defaultTaxRate == this.defaultTaxRate &&
          other.defaultPaymentTerms == this.defaultPaymentTerms &&
          other.defaultPaymentTermsDays == this.defaultPaymentTermsDays &&
          other.lateFeePercentage == this.lateFeePercentage &&
          other.defaultTemplateId == this.defaultTemplateId &&
          other.defaultEmailSubjectFormat == this.defaultEmailSubjectFormat &&
          other.nextInvoiceNumber == this.nextInvoiceNumber &&
          other.invoiceNumberPrefix == this.invoiceNumberPrefix &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> businessName;
  final Value<String> ownerName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> addressLine1;
  final Value<String?> addressLine2;
  final Value<String?> city;
  final Value<String?> stateProvince;
  final Value<String?> postalCode;
  final Value<String?> country;
  final Value<String?> taxId;
  final Value<bool> showTaxId;
  final Value<String?> waBusinessLicense;
  final Value<bool> showWaLicense;
  final Value<String?> logoPath;
  final Value<String?> bankName;
  final Value<String?> bankAccountName;
  final Value<String?> bankAccountNumber;
  final Value<String?> bankRoutingNumber;
  final Value<String> bankAccountType;
  final Value<String?> bankSwift;
  final Value<String?> bankIban;
  final Value<bool> showBankDetails;
  final Value<String?> stripePaymentLink;
  final Value<bool> showStripeLink;
  final Value<String?> paymentInstructions;
  final Value<String> defaultCurrency;
  final Value<double> defaultHourlyRate;
  final Value<String> defaultTaxLabel;
  final Value<double> defaultTaxRate;
  final Value<String> defaultPaymentTerms;
  final Value<int> defaultPaymentTermsDays;
  final Value<double?> lateFeePercentage;
  final Value<int?> defaultTemplateId;
  final Value<String> defaultEmailSubjectFormat;
  final Value<int> nextInvoiceNumber;
  final Value<String> invoiceNumberPrefix;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.country = const Value.absent(),
    this.taxId = const Value.absent(),
    this.showTaxId = const Value.absent(),
    this.waBusinessLicense = const Value.absent(),
    this.showWaLicense = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.bankName = const Value.absent(),
    this.bankAccountName = const Value.absent(),
    this.bankAccountNumber = const Value.absent(),
    this.bankRoutingNumber = const Value.absent(),
    this.bankAccountType = const Value.absent(),
    this.bankSwift = const Value.absent(),
    this.bankIban = const Value.absent(),
    this.showBankDetails = const Value.absent(),
    this.stripePaymentLink = const Value.absent(),
    this.showStripeLink = const Value.absent(),
    this.paymentInstructions = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.defaultHourlyRate = const Value.absent(),
    this.defaultTaxLabel = const Value.absent(),
    this.defaultTaxRate = const Value.absent(),
    this.defaultPaymentTerms = const Value.absent(),
    this.defaultPaymentTermsDays = const Value.absent(),
    this.lateFeePercentage = const Value.absent(),
    this.defaultTemplateId = const Value.absent(),
    this.defaultEmailSubjectFormat = const Value.absent(),
    this.nextInvoiceNumber = const Value.absent(),
    this.invoiceNumberPrefix = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.country = const Value.absent(),
    this.taxId = const Value.absent(),
    this.showTaxId = const Value.absent(),
    this.waBusinessLicense = const Value.absent(),
    this.showWaLicense = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.bankName = const Value.absent(),
    this.bankAccountName = const Value.absent(),
    this.bankAccountNumber = const Value.absent(),
    this.bankRoutingNumber = const Value.absent(),
    this.bankAccountType = const Value.absent(),
    this.bankSwift = const Value.absent(),
    this.bankIban = const Value.absent(),
    this.showBankDetails = const Value.absent(),
    this.stripePaymentLink = const Value.absent(),
    this.showStripeLink = const Value.absent(),
    this.paymentInstructions = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.defaultHourlyRate = const Value.absent(),
    this.defaultTaxLabel = const Value.absent(),
    this.defaultTaxRate = const Value.absent(),
    this.defaultPaymentTerms = const Value.absent(),
    this.defaultPaymentTermsDays = const Value.absent(),
    this.lateFeePercentage = const Value.absent(),
    this.defaultTemplateId = const Value.absent(),
    this.defaultEmailSubjectFormat = const Value.absent(),
    this.nextInvoiceNumber = const Value.absent(),
    this.invoiceNumberPrefix = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? businessName,
    Expression<String>? ownerName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? city,
    Expression<String>? stateProvince,
    Expression<String>? postalCode,
    Expression<String>? country,
    Expression<String>? taxId,
    Expression<bool>? showTaxId,
    Expression<String>? waBusinessLicense,
    Expression<bool>? showWaLicense,
    Expression<String>? logoPath,
    Expression<String>? bankName,
    Expression<String>? bankAccountName,
    Expression<String>? bankAccountNumber,
    Expression<String>? bankRoutingNumber,
    Expression<String>? bankAccountType,
    Expression<String>? bankSwift,
    Expression<String>? bankIban,
    Expression<bool>? showBankDetails,
    Expression<String>? stripePaymentLink,
    Expression<bool>? showStripeLink,
    Expression<String>? paymentInstructions,
    Expression<String>? defaultCurrency,
    Expression<double>? defaultHourlyRate,
    Expression<String>? defaultTaxLabel,
    Expression<double>? defaultTaxRate,
    Expression<String>? defaultPaymentTerms,
    Expression<int>? defaultPaymentTermsDays,
    Expression<double>? lateFeePercentage,
    Expression<int>? defaultTemplateId,
    Expression<String>? defaultEmailSubjectFormat,
    Expression<int>? nextInvoiceNumber,
    Expression<String>? invoiceNumberPrefix,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessName != null) 'business_name': businessName,
      if (ownerName != null) 'owner_name': ownerName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (city != null) 'city': city,
      if (stateProvince != null) 'state_province': stateProvince,
      if (postalCode != null) 'postal_code': postalCode,
      if (country != null) 'country': country,
      if (taxId != null) 'tax_id': taxId,
      if (showTaxId != null) 'show_tax_id': showTaxId,
      if (waBusinessLicense != null) 'wa_business_license': waBusinessLicense,
      if (showWaLicense != null) 'show_wa_license': showWaLicense,
      if (logoPath != null) 'logo_path': logoPath,
      if (bankName != null) 'bank_name': bankName,
      if (bankAccountName != null) 'bank_account_name': bankAccountName,
      if (bankAccountNumber != null) 'bank_account_number': bankAccountNumber,
      if (bankRoutingNumber != null) 'bank_routing_number': bankRoutingNumber,
      if (bankAccountType != null) 'bank_account_type': bankAccountType,
      if (bankSwift != null) 'bank_swift': bankSwift,
      if (bankIban != null) 'bank_iban': bankIban,
      if (showBankDetails != null) 'show_bank_details': showBankDetails,
      if (stripePaymentLink != null) 'stripe_payment_link': stripePaymentLink,
      if (showStripeLink != null) 'show_stripe_link': showStripeLink,
      if (paymentInstructions != null)
        'payment_instructions': paymentInstructions,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (defaultHourlyRate != null) 'default_hourly_rate': defaultHourlyRate,
      if (defaultTaxLabel != null) 'default_tax_label': defaultTaxLabel,
      if (defaultTaxRate != null) 'default_tax_rate': defaultTaxRate,
      if (defaultPaymentTerms != null)
        'default_payment_terms': defaultPaymentTerms,
      if (defaultPaymentTermsDays != null)
        'default_payment_terms_days': defaultPaymentTermsDays,
      if (lateFeePercentage != null) 'late_fee_percentage': lateFeePercentage,
      if (defaultTemplateId != null) 'default_template_id': defaultTemplateId,
      if (defaultEmailSubjectFormat != null)
        'default_email_subject_format': defaultEmailSubjectFormat,
      if (nextInvoiceNumber != null) 'next_invoice_number': nextInvoiceNumber,
      if (invoiceNumberPrefix != null)
        'invoice_number_prefix': invoiceNumberPrefix,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? businessName,
    Value<String>? ownerName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? addressLine1,
    Value<String?>? addressLine2,
    Value<String?>? city,
    Value<String?>? stateProvince,
    Value<String?>? postalCode,
    Value<String?>? country,
    Value<String?>? taxId,
    Value<bool>? showTaxId,
    Value<String?>? waBusinessLicense,
    Value<bool>? showWaLicense,
    Value<String?>? logoPath,
    Value<String?>? bankName,
    Value<String?>? bankAccountName,
    Value<String?>? bankAccountNumber,
    Value<String?>? bankRoutingNumber,
    Value<String>? bankAccountType,
    Value<String?>? bankSwift,
    Value<String?>? bankIban,
    Value<bool>? showBankDetails,
    Value<String?>? stripePaymentLink,
    Value<bool>? showStripeLink,
    Value<String?>? paymentInstructions,
    Value<String>? defaultCurrency,
    Value<double>? defaultHourlyRate,
    Value<String>? defaultTaxLabel,
    Value<double>? defaultTaxRate,
    Value<String>? defaultPaymentTerms,
    Value<int>? defaultPaymentTermsDays,
    Value<double?>? lateFeePercentage,
    Value<int?>? defaultTemplateId,
    Value<String>? defaultEmailSubjectFormat,
    Value<int>? nextInvoiceNumber,
    Value<String>? invoiceNumberPrefix,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      stateProvince: stateProvince ?? this.stateProvince,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      taxId: taxId ?? this.taxId,
      showTaxId: showTaxId ?? this.showTaxId,
      waBusinessLicense: waBusinessLicense ?? this.waBusinessLicense,
      showWaLicense: showWaLicense ?? this.showWaLicense,
      logoPath: logoPath ?? this.logoPath,
      bankName: bankName ?? this.bankName,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankRoutingNumber: bankRoutingNumber ?? this.bankRoutingNumber,
      bankAccountType: bankAccountType ?? this.bankAccountType,
      bankSwift: bankSwift ?? this.bankSwift,
      bankIban: bankIban ?? this.bankIban,
      showBankDetails: showBankDetails ?? this.showBankDetails,
      stripePaymentLink: stripePaymentLink ?? this.stripePaymentLink,
      showStripeLink: showStripeLink ?? this.showStripeLink,
      paymentInstructions: paymentInstructions ?? this.paymentInstructions,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      defaultHourlyRate: defaultHourlyRate ?? this.defaultHourlyRate,
      defaultTaxLabel: defaultTaxLabel ?? this.defaultTaxLabel,
      defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
      defaultPaymentTerms: defaultPaymentTerms ?? this.defaultPaymentTerms,
      defaultPaymentTermsDays:
          defaultPaymentTermsDays ?? this.defaultPaymentTermsDays,
      lateFeePercentage: lateFeePercentage ?? this.lateFeePercentage,
      defaultTemplateId: defaultTemplateId ?? this.defaultTemplateId,
      defaultEmailSubjectFormat:
          defaultEmailSubjectFormat ?? this.defaultEmailSubjectFormat,
      nextInvoiceNumber: nextInvoiceNumber ?? this.nextInvoiceNumber,
      invoiceNumberPrefix: invoiceNumberPrefix ?? this.invoiceNumberPrefix,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (stateProvince.present) {
      map['state_province'] = Variable<String>(stateProvince.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<String>(taxId.value);
    }
    if (showTaxId.present) {
      map['show_tax_id'] = Variable<bool>(showTaxId.value);
    }
    if (waBusinessLicense.present) {
      map['wa_business_license'] = Variable<String>(waBusinessLicense.value);
    }
    if (showWaLicense.present) {
      map['show_wa_license'] = Variable<bool>(showWaLicense.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (bankAccountName.present) {
      map['bank_account_name'] = Variable<String>(bankAccountName.value);
    }
    if (bankAccountNumber.present) {
      map['bank_account_number'] = Variable<String>(bankAccountNumber.value);
    }
    if (bankRoutingNumber.present) {
      map['bank_routing_number'] = Variable<String>(bankRoutingNumber.value);
    }
    if (bankAccountType.present) {
      map['bank_account_type'] = Variable<String>(bankAccountType.value);
    }
    if (bankSwift.present) {
      map['bank_swift'] = Variable<String>(bankSwift.value);
    }
    if (bankIban.present) {
      map['bank_iban'] = Variable<String>(bankIban.value);
    }
    if (showBankDetails.present) {
      map['show_bank_details'] = Variable<bool>(showBankDetails.value);
    }
    if (stripePaymentLink.present) {
      map['stripe_payment_link'] = Variable<String>(stripePaymentLink.value);
    }
    if (showStripeLink.present) {
      map['show_stripe_link'] = Variable<bool>(showStripeLink.value);
    }
    if (paymentInstructions.present) {
      map['payment_instructions'] = Variable<String>(paymentInstructions.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (defaultHourlyRate.present) {
      map['default_hourly_rate'] = Variable<double>(defaultHourlyRate.value);
    }
    if (defaultTaxLabel.present) {
      map['default_tax_label'] = Variable<String>(defaultTaxLabel.value);
    }
    if (defaultTaxRate.present) {
      map['default_tax_rate'] = Variable<double>(defaultTaxRate.value);
    }
    if (defaultPaymentTerms.present) {
      map['default_payment_terms'] = Variable<String>(
        defaultPaymentTerms.value,
      );
    }
    if (defaultPaymentTermsDays.present) {
      map['default_payment_terms_days'] = Variable<int>(
        defaultPaymentTermsDays.value,
      );
    }
    if (lateFeePercentage.present) {
      map['late_fee_percentage'] = Variable<double>(lateFeePercentage.value);
    }
    if (defaultTemplateId.present) {
      map['default_template_id'] = Variable<int>(defaultTemplateId.value);
    }
    if (defaultEmailSubjectFormat.present) {
      map['default_email_subject_format'] = Variable<String>(
        defaultEmailSubjectFormat.value,
      );
    }
    if (nextInvoiceNumber.present) {
      map['next_invoice_number'] = Variable<int>(nextInvoiceNumber.value);
    }
    if (invoiceNumberPrefix.present) {
      map['invoice_number_prefix'] = Variable<String>(
        invoiceNumberPrefix.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('ownerName: $ownerName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('postalCode: $postalCode, ')
          ..write('country: $country, ')
          ..write('taxId: $taxId, ')
          ..write('showTaxId: $showTaxId, ')
          ..write('waBusinessLicense: $waBusinessLicense, ')
          ..write('showWaLicense: $showWaLicense, ')
          ..write('logoPath: $logoPath, ')
          ..write('bankName: $bankName, ')
          ..write('bankAccountName: $bankAccountName, ')
          ..write('bankAccountNumber: $bankAccountNumber, ')
          ..write('bankRoutingNumber: $bankRoutingNumber, ')
          ..write('bankAccountType: $bankAccountType, ')
          ..write('bankSwift: $bankSwift, ')
          ..write('bankIban: $bankIban, ')
          ..write('showBankDetails: $showBankDetails, ')
          ..write('stripePaymentLink: $stripePaymentLink, ')
          ..write('showStripeLink: $showStripeLink, ')
          ..write('paymentInstructions: $paymentInstructions, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('defaultHourlyRate: $defaultHourlyRate, ')
          ..write('defaultTaxLabel: $defaultTaxLabel, ')
          ..write('defaultTaxRate: $defaultTaxRate, ')
          ..write('defaultPaymentTerms: $defaultPaymentTerms, ')
          ..write('defaultPaymentTermsDays: $defaultPaymentTermsDays, ')
          ..write('lateFeePercentage: $lateFeePercentage, ')
          ..write('defaultTemplateId: $defaultTemplateId, ')
          ..write('defaultEmailSubjectFormat: $defaultEmailSubjectFormat, ')
          ..write('nextInvoiceNumber: $nextInvoiceNumber, ')
          ..write('invoiceNumberPrefix: $invoiceNumberPrefix, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressLine1Meta = const VerificationMeta(
    'addressLine1',
  );
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
    'address_line1',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressLine2Meta = const VerificationMeta(
    'addressLine2',
  );
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
    'address_line2',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateProvinceMeta = const VerificationMeta(
    'stateProvince',
  );
  @override
  late final GeneratedColumn<String> stateProvince = GeneratedColumn<String>(
    'state_province',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourlyRateMeta = const VerificationMeta(
    'hourlyRate',
  );
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
    'hourly_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
    'tax_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultTemplateIdMeta = const VerificationMeta(
    'defaultTemplateId',
  );
  @override
  late final GeneratedColumn<int> defaultTemplateId = GeneratedColumn<int>(
    'default_template_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoice_templates (id)',
    ),
  );
  static const VerificationMeta _paymentTermsOverrideMeta =
      const VerificationMeta('paymentTermsOverride');
  @override
  late final GeneratedColumn<String> paymentTermsOverride =
      GeneratedColumn<String>(
        'payment_terms_override',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _paymentTermsDaysOverrideMeta =
      const VerificationMeta('paymentTermsDaysOverride');
  @override
  late final GeneratedColumn<int> paymentTermsDaysOverride =
      GeneratedColumn<int>(
        'payment_terms_days_override',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    contactName,
    email,
    phone,
    addressLine1,
    addressLine2,
    city,
    stateProvince,
    postalCode,
    country,
    hourlyRate,
    currency,
    taxRate,
    defaultTemplateId,
    paymentTermsOverride,
    paymentTermsDaysOverride,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address_line1')) {
      context.handle(
        _addressLine1Meta,
        addressLine1.isAcceptableOrUnknown(
          data['address_line1']!,
          _addressLine1Meta,
        ),
      );
    }
    if (data.containsKey('address_line2')) {
      context.handle(
        _addressLine2Meta,
        addressLine2.isAcceptableOrUnknown(
          data['address_line2']!,
          _addressLine2Meta,
        ),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('state_province')) {
      context.handle(
        _stateProvinceMeta,
        stateProvince.isAcceptableOrUnknown(
          data['state_province']!,
          _stateProvinceMeta,
        ),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
        _hourlyRateMeta,
        hourlyRate.isAcceptableOrUnknown(data['hourly_rate']!, _hourlyRateMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    }
    if (data.containsKey('default_template_id')) {
      context.handle(
        _defaultTemplateIdMeta,
        defaultTemplateId.isAcceptableOrUnknown(
          data['default_template_id']!,
          _defaultTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('payment_terms_override')) {
      context.handle(
        _paymentTermsOverrideMeta,
        paymentTermsOverride.isAcceptableOrUnknown(
          data['payment_terms_override']!,
          _paymentTermsOverrideMeta,
        ),
      );
    }
    if (data.containsKey('payment_terms_days_override')) {
      context.handle(
        _paymentTermsDaysOverrideMeta,
        paymentTermsDaysOverride.isAcceptableOrUnknown(
          data['payment_terms_days_override']!,
          _paymentTermsDaysOverrideMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      addressLine1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line1'],
      ),
      addressLine2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line2'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      stateProvince: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_province'],
      ),
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      hourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_rate'],
      ),
      defaultTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_template_id'],
      ),
      paymentTermsOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_terms_override'],
      ),
      paymentTermsDaysOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_terms_days_override'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String? contactName;
  final String? email;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? stateProvince;
  final String? postalCode;
  final String? country;
  final double? hourlyRate;
  final String currency;
  final double? taxRate;
  final int? defaultTemplateId;
  final String? paymentTermsOverride;
  final int? paymentTermsDaysOverride;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Client({
    required this.id,
    required this.name,
    this.contactName,
    this.email,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    this.hourlyRate,
    required this.currency,
    this.taxRate,
    this.defaultTemplateId,
    this.paymentTermsOverride,
    this.paymentTermsDaysOverride,
    this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || addressLine1 != null) {
      map['address_line1'] = Variable<String>(addressLine1);
    }
    if (!nullToAbsent || addressLine2 != null) {
      map['address_line2'] = Variable<String>(addressLine2);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || stateProvince != null) {
      map['state_province'] = Variable<String>(stateProvince);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || hourlyRate != null) {
      map['hourly_rate'] = Variable<double>(hourlyRate);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || taxRate != null) {
      map['tax_rate'] = Variable<double>(taxRate);
    }
    if (!nullToAbsent || defaultTemplateId != null) {
      map['default_template_id'] = Variable<int>(defaultTemplateId);
    }
    if (!nullToAbsent || paymentTermsOverride != null) {
      map['payment_terms_override'] = Variable<String>(paymentTermsOverride);
    }
    if (!nullToAbsent || paymentTermsDaysOverride != null) {
      map['payment_terms_days_override'] = Variable<int>(
        paymentTermsDaysOverride,
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      addressLine1: addressLine1 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine1),
      addressLine2: addressLine2 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine2),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      stateProvince: stateProvince == null && nullToAbsent
          ? const Value.absent()
          : Value(stateProvince),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      hourlyRate: hourlyRate == null && nullToAbsent
          ? const Value.absent()
          : Value(hourlyRate),
      currency: Value(currency),
      taxRate: taxRate == null && nullToAbsent
          ? const Value.absent()
          : Value(taxRate),
      defaultTemplateId: defaultTemplateId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultTemplateId),
      paymentTermsOverride: paymentTermsOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentTermsOverride),
      paymentTermsDaysOverride: paymentTermsDaysOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentTermsDaysOverride),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      addressLine1: serializer.fromJson<String?>(json['addressLine1']),
      addressLine2: serializer.fromJson<String?>(json['addressLine2']),
      city: serializer.fromJson<String?>(json['city']),
      stateProvince: serializer.fromJson<String?>(json['stateProvince']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      country: serializer.fromJson<String?>(json['country']),
      hourlyRate: serializer.fromJson<double?>(json['hourlyRate']),
      currency: serializer.fromJson<String>(json['currency']),
      taxRate: serializer.fromJson<double?>(json['taxRate']),
      defaultTemplateId: serializer.fromJson<int?>(json['defaultTemplateId']),
      paymentTermsOverride: serializer.fromJson<String?>(
        json['paymentTermsOverride'],
      ),
      paymentTermsDaysOverride: serializer.fromJson<int?>(
        json['paymentTermsDaysOverride'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'contactName': serializer.toJson<String?>(contactName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'addressLine1': serializer.toJson<String?>(addressLine1),
      'addressLine2': serializer.toJson<String?>(addressLine2),
      'city': serializer.toJson<String?>(city),
      'stateProvince': serializer.toJson<String?>(stateProvince),
      'postalCode': serializer.toJson<String?>(postalCode),
      'country': serializer.toJson<String?>(country),
      'hourlyRate': serializer.toJson<double?>(hourlyRate),
      'currency': serializer.toJson<String>(currency),
      'taxRate': serializer.toJson<double?>(taxRate),
      'defaultTemplateId': serializer.toJson<int?>(defaultTemplateId),
      'paymentTermsOverride': serializer.toJson<String?>(paymentTermsOverride),
      'paymentTermsDaysOverride': serializer.toJson<int?>(
        paymentTermsDaysOverride,
      ),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Client copyWith({
    int? id,
    String? name,
    Value<String?> contactName = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> addressLine1 = const Value.absent(),
    Value<String?> addressLine2 = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> stateProvince = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<double?> hourlyRate = const Value.absent(),
    String? currency,
    Value<double?> taxRate = const Value.absent(),
    Value<int?> defaultTemplateId = const Value.absent(),
    Value<String?> paymentTermsOverride = const Value.absent(),
    Value<int?> paymentTermsDaysOverride = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Client(
    id: id ?? this.id,
    name: name ?? this.name,
    contactName: contactName.present ? contactName.value : this.contactName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    addressLine1: addressLine1.present ? addressLine1.value : this.addressLine1,
    addressLine2: addressLine2.present ? addressLine2.value : this.addressLine2,
    city: city.present ? city.value : this.city,
    stateProvince: stateProvince.present
        ? stateProvince.value
        : this.stateProvince,
    postalCode: postalCode.present ? postalCode.value : this.postalCode,
    country: country.present ? country.value : this.country,
    hourlyRate: hourlyRate.present ? hourlyRate.value : this.hourlyRate,
    currency: currency ?? this.currency,
    taxRate: taxRate.present ? taxRate.value : this.taxRate,
    defaultTemplateId: defaultTemplateId.present
        ? defaultTemplateId.value
        : this.defaultTemplateId,
    paymentTermsOverride: paymentTermsOverride.present
        ? paymentTermsOverride.value
        : this.paymentTermsOverride,
    paymentTermsDaysOverride: paymentTermsDaysOverride.present
        ? paymentTermsDaysOverride.value
        : this.paymentTermsDaysOverride,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      city: data.city.present ? data.city.value : this.city,
      stateProvince: data.stateProvince.present
          ? data.stateProvince.value
          : this.stateProvince,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      country: data.country.present ? data.country.value : this.country,
      hourlyRate: data.hourlyRate.present
          ? data.hourlyRate.value
          : this.hourlyRate,
      currency: data.currency.present ? data.currency.value : this.currency,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      defaultTemplateId: data.defaultTemplateId.present
          ? data.defaultTemplateId.value
          : this.defaultTemplateId,
      paymentTermsOverride: data.paymentTermsOverride.present
          ? data.paymentTermsOverride.value
          : this.paymentTermsOverride,
      paymentTermsDaysOverride: data.paymentTermsDaysOverride.present
          ? data.paymentTermsDaysOverride.value
          : this.paymentTermsDaysOverride,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('postalCode: $postalCode, ')
          ..write('country: $country, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('currency: $currency, ')
          ..write('taxRate: $taxRate, ')
          ..write('defaultTemplateId: $defaultTemplateId, ')
          ..write('paymentTermsOverride: $paymentTermsOverride, ')
          ..write('paymentTermsDaysOverride: $paymentTermsDaysOverride, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    contactName,
    email,
    phone,
    addressLine1,
    addressLine2,
    city,
    stateProvince,
    postalCode,
    country,
    hourlyRate,
    currency,
    taxRate,
    defaultTemplateId,
    paymentTermsOverride,
    paymentTermsDaysOverride,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.contactName == this.contactName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.city == this.city &&
          other.stateProvince == this.stateProvince &&
          other.postalCode == this.postalCode &&
          other.country == this.country &&
          other.hourlyRate == this.hourlyRate &&
          other.currency == this.currency &&
          other.taxRate == this.taxRate &&
          other.defaultTemplateId == this.defaultTemplateId &&
          other.paymentTermsOverride == this.paymentTermsOverride &&
          other.paymentTermsDaysOverride == this.paymentTermsDaysOverride &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> contactName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> addressLine1;
  final Value<String?> addressLine2;
  final Value<String?> city;
  final Value<String?> stateProvince;
  final Value<String?> postalCode;
  final Value<String?> country;
  final Value<double?> hourlyRate;
  final Value<String> currency;
  final Value<double?> taxRate;
  final Value<int?> defaultTemplateId;
  final Value<String?> paymentTermsOverride;
  final Value<int?> paymentTermsDaysOverride;
  final Value<String?> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.country = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.currency = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.defaultTemplateId = const Value.absent(),
    this.paymentTermsOverride = const Value.absent(),
    this.paymentTermsDaysOverride = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.country = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.currency = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.defaultTemplateId = const Value.absent(),
    this.paymentTermsOverride = const Value.absent(),
    this.paymentTermsDaysOverride = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? contactName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? city,
    Expression<String>? stateProvince,
    Expression<String>? postalCode,
    Expression<String>? country,
    Expression<double>? hourlyRate,
    Expression<String>? currency,
    Expression<double>? taxRate,
    Expression<int>? defaultTemplateId,
    Expression<String>? paymentTermsOverride,
    Expression<int>? paymentTermsDaysOverride,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contactName != null) 'contact_name': contactName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (city != null) 'city': city,
      if (stateProvince != null) 'state_province': stateProvince,
      if (postalCode != null) 'postal_code': postalCode,
      if (country != null) 'country': country,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (currency != null) 'currency': currency,
      if (taxRate != null) 'tax_rate': taxRate,
      if (defaultTemplateId != null) 'default_template_id': defaultTemplateId,
      if (paymentTermsOverride != null)
        'payment_terms_override': paymentTermsOverride,
      if (paymentTermsDaysOverride != null)
        'payment_terms_days_override': paymentTermsDaysOverride,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? contactName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? addressLine1,
    Value<String?>? addressLine2,
    Value<String?>? city,
    Value<String?>? stateProvince,
    Value<String?>? postalCode,
    Value<String?>? country,
    Value<double?>? hourlyRate,
    Value<String>? currency,
    Value<double?>? taxRate,
    Value<int?>? defaultTemplateId,
    Value<String?>? paymentTermsOverride,
    Value<int?>? paymentTermsDaysOverride,
    Value<String?>? notes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      stateProvince: stateProvince ?? this.stateProvince,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      currency: currency ?? this.currency,
      taxRate: taxRate ?? this.taxRate,
      defaultTemplateId: defaultTemplateId ?? this.defaultTemplateId,
      paymentTermsOverride: paymentTermsOverride ?? this.paymentTermsOverride,
      paymentTermsDaysOverride:
          paymentTermsDaysOverride ?? this.paymentTermsDaysOverride,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (stateProvince.present) {
      map['state_province'] = Variable<String>(stateProvince.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    if (defaultTemplateId.present) {
      map['default_template_id'] = Variable<int>(defaultTemplateId.value);
    }
    if (paymentTermsOverride.present) {
      map['payment_terms_override'] = Variable<String>(
        paymentTermsOverride.value,
      );
    }
    if (paymentTermsDaysOverride.present) {
      map['payment_terms_days_override'] = Variable<int>(
        paymentTermsDaysOverride.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('postalCode: $postalCode, ')
          ..write('country: $country, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('currency: $currency, ')
          ..write('taxRate: $taxRate, ')
          ..write('defaultTemplateId: $defaultTemplateId, ')
          ..write('paymentTermsOverride: $paymentTermsOverride, ')
          ..write('paymentTermsDaysOverride: $paymentTermsDaysOverride, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourlyRateOverrideMeta =
      const VerificationMeta('hourlyRateOverride');
  @override
  late final GeneratedColumn<double> hourlyRateOverride =
      GeneratedColumn<double>(
        'hourly_rate_override',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF2196F3),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    name,
    description,
    hourlyRateOverride,
    color,
    isActive,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('hourly_rate_override')) {
      context.handle(
        _hourlyRateOverrideMeta,
        hourlyRateOverride.isAcceptableOrUnknown(
          data['hourly_rate_override']!,
          _hourlyRateOverrideMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {clientId, name},
  ];
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      hourlyRateOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate_override'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final int clientId;
  final String name;
  final String? description;
  final double? hourlyRateOverride;
  final int color;
  final bool isActive;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Project({
    required this.id,
    required this.clientId,
    required this.name,
    this.description,
    this.hourlyRateOverride,
    required this.color,
    required this.isActive,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || hourlyRateOverride != null) {
      map['hourly_rate_override'] = Variable<double>(hourlyRateOverride);
    }
    map['color'] = Variable<int>(color);
    map['is_active'] = Variable<bool>(isActive);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      hourlyRateOverride: hourlyRateOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(hourlyRateOverride),
      color: Value(color),
      isActive: Value(isActive),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      hourlyRateOverride: serializer.fromJson<double?>(
        json['hourlyRateOverride'],
      ),
      color: serializer.fromJson<int>(json['color']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'hourlyRateOverride': serializer.toJson<double?>(hourlyRateOverride),
      'color': serializer.toJson<int>(color),
      'isActive': serializer.toJson<bool>(isActive),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Project copyWith({
    int? id,
    int? clientId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<double?> hourlyRateOverride = const Value.absent(),
    int? color,
    bool? isActive,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Project(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    hourlyRateOverride: hourlyRateOverride.present
        ? hourlyRateOverride.value
        : this.hourlyRateOverride,
    color: color ?? this.color,
    isActive: isActive ?? this.isActive,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      hourlyRateOverride: data.hourlyRateOverride.present
          ? data.hourlyRateOverride.value
          : this.hourlyRateOverride,
      color: data.color.present ? data.color.value : this.color,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('hourlyRateOverride: $hourlyRateOverride, ')
          ..write('color: $color, ')
          ..write('isActive: $isActive, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    name,
    description,
    hourlyRateOverride,
    color,
    isActive,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.name == this.name &&
          other.description == this.description &&
          other.hourlyRateOverride == this.hourlyRateOverride &&
          other.color == this.color &&
          other.isActive == this.isActive &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> name;
  final Value<String?> description;
  final Value<double?> hourlyRateOverride;
  final Value<int> color;
  final Value<bool> isActive;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.hourlyRateOverride = const Value.absent(),
    this.color = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String name,
    this.description = const Value.absent(),
    this.hourlyRateOverride = const Value.absent(),
    this.color = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       name = Value(name);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? hourlyRateOverride,
    Expression<int>? color,
    Expression<bool>? isActive,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (hourlyRateOverride != null)
        'hourly_rate_override': hourlyRateOverride,
      if (color != null) 'color': color,
      if (isActive != null) 'is_active': isActive,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<String>? name,
    Value<String?>? description,
    Value<double?>? hourlyRateOverride,
    Value<int>? color,
    Value<bool>? isActive,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      description: description ?? this.description,
      hourlyRateOverride: hourlyRateOverride ?? this.hourlyRateOverride,
      color: color ?? this.color,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (hourlyRateOverride.present) {
      map['hourly_rate_override'] = Variable<double>(hourlyRateOverride.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('hourlyRateOverride: $hourlyRateOverride, ')
          ..write('color: $color, ')
          ..write('isActive: $isActive, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodStartMeta = const VerificationMeta(
    'periodStart',
  );
  @override
  late final GeneratedColumn<DateTime> periodStart = GeneratedColumn<DateTime>(
    'period_start',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodEndMeta = const VerificationMeta(
    'periodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> periodEnd = GeneratedColumn<DateTime>(
    'period_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxLabelMeta = const VerificationMeta(
    'taxLabel',
  );
  @override
  late final GeneratedColumn<String> taxLabel = GeneratedColumn<String>(
    'tax_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Tax'),
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lateFeeAmountMeta = const VerificationMeta(
    'lateFeeAmount',
  );
  @override
  late final GeneratedColumn<double> lateFeeAmount = GeneratedColumn<double>(
    'late_fee_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoice_templates (id)',
    ),
  );
  static const VerificationMeta _templateTypeMeta = const VerificationMeta(
    'templateType',
  );
  @override
  late final GeneratedColumn<String> templateType = GeneratedColumn<String>(
    'template_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('detailed'),
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidDateMeta = const VerificationMeta(
    'paidDate',
  );
  @override
  late final GeneratedColumn<DateTime> paidDate = GeneratedColumn<DateTime>(
    'paid_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentDateMeta = const VerificationMeta(
    'sentDate',
  );
  @override
  late final GeneratedColumn<DateTime> sentDate = GeneratedColumn<DateTime>(
    'sent_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    invoiceNumber,
    status,
    issueDate,
    dueDate,
    periodStart,
    periodEnd,
    subtotal,
    taxRate,
    taxLabel,
    taxAmount,
    lateFeeAmount,
    total,
    amountPaid,
    currency,
    notes,
    templateId,
    templateType,
    pdfPath,
    paymentMethod,
    paidDate,
    sentDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('period_start')) {
      context.handle(
        _periodStartMeta,
        periodStart.isAcceptableOrUnknown(
          data['period_start']!,
          _periodStartMeta,
        ),
      );
    }
    if (data.containsKey('period_end')) {
      context.handle(
        _periodEndMeta,
        periodEnd.isAcceptableOrUnknown(data['period_end']!, _periodEndMeta),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    }
    if (data.containsKey('tax_label')) {
      context.handle(
        _taxLabelMeta,
        taxLabel.isAcceptableOrUnknown(data['tax_label']!, _taxLabelMeta),
      );
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('late_fee_amount')) {
      context.handle(
        _lateFeeAmountMeta,
        lateFeeAmount.isAcceptableOrUnknown(
          data['late_fee_amount']!,
          _lateFeeAmountMeta,
        ),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('template_type')) {
      context.handle(
        _templateTypeMeta,
        templateType.isAcceptableOrUnknown(
          data['template_type']!,
          _templateTypeMeta,
        ),
      );
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('paid_date')) {
      context.handle(
        _paidDateMeta,
        paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta),
      );
    }
    if (data.containsKey('sent_date')) {
      context.handle(
        _sentDateMeta,
        sentDate.isAcceptableOrUnknown(data['sent_date']!, _sentDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      periodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_start'],
      ),
      periodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_end'],
      ),
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_rate'],
      )!,
      taxLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_label'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      lateFeeAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}late_fee_amount'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      amountPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_paid'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      ),
      templateType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_type'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      paidDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_date'],
      ),
      sentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final int clientId;
  final String invoiceNumber;
  final String status;
  final DateTime issueDate;
  final DateTime dueDate;
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final double subtotal;
  final double taxRate;
  final String taxLabel;
  final double taxAmount;
  final double lateFeeAmount;
  final double total;
  final double amountPaid;
  final String currency;
  final String? notes;
  final int? templateId;
  final String templateType;
  final String? pdfPath;
  final String? paymentMethod;
  final DateTime? paidDate;
  final DateTime? sentDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Invoice({
    required this.id,
    required this.clientId,
    required this.invoiceNumber,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    this.periodStart,
    this.periodEnd,
    required this.subtotal,
    required this.taxRate,
    required this.taxLabel,
    required this.taxAmount,
    required this.lateFeeAmount,
    required this.total,
    required this.amountPaid,
    required this.currency,
    this.notes,
    this.templateId,
    required this.templateType,
    this.pdfPath,
    this.paymentMethod,
    this.paidDate,
    this.sentDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['status'] = Variable<String>(status);
    map['issue_date'] = Variable<DateTime>(issueDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || periodStart != null) {
      map['period_start'] = Variable<DateTime>(periodStart);
    }
    if (!nullToAbsent || periodEnd != null) {
      map['period_end'] = Variable<DateTime>(periodEnd);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['tax_rate'] = Variable<double>(taxRate);
    map['tax_label'] = Variable<String>(taxLabel);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['late_fee_amount'] = Variable<double>(lateFeeAmount);
    map['total'] = Variable<double>(total);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<int>(templateId);
    }
    map['template_type'] = Variable<String>(templateType);
    if (!nullToAbsent || pdfPath != null) {
      map['pdf_path'] = Variable<String>(pdfPath);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || paidDate != null) {
      map['paid_date'] = Variable<DateTime>(paidDate);
    }
    if (!nullToAbsent || sentDate != null) {
      map['sent_date'] = Variable<DateTime>(sentDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      invoiceNumber: Value(invoiceNumber),
      status: Value(status),
      issueDate: Value(issueDate),
      dueDate: Value(dueDate),
      periodStart: periodStart == null && nullToAbsent
          ? const Value.absent()
          : Value(periodStart),
      periodEnd: periodEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(periodEnd),
      subtotal: Value(subtotal),
      taxRate: Value(taxRate),
      taxLabel: Value(taxLabel),
      taxAmount: Value(taxAmount),
      lateFeeAmount: Value(lateFeeAmount),
      total: Value(total),
      amountPaid: Value(amountPaid),
      currency: Value(currency),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      templateType: Value(templateType),
      pdfPath: pdfPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfPath),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      paidDate: paidDate == null && nullToAbsent
          ? const Value.absent()
          : Value(paidDate),
      sentDate: sentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(sentDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      status: serializer.fromJson<String>(json['status']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      periodStart: serializer.fromJson<DateTime?>(json['periodStart']),
      periodEnd: serializer.fromJson<DateTime?>(json['periodEnd']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      taxRate: serializer.fromJson<double>(json['taxRate']),
      taxLabel: serializer.fromJson<String>(json['taxLabel']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      lateFeeAmount: serializer.fromJson<double>(json['lateFeeAmount']),
      total: serializer.fromJson<double>(json['total']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      currency: serializer.fromJson<String>(json['currency']),
      notes: serializer.fromJson<String?>(json['notes']),
      templateId: serializer.fromJson<int?>(json['templateId']),
      templateType: serializer.fromJson<String>(json['templateType']),
      pdfPath: serializer.fromJson<String?>(json['pdfPath']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      paidDate: serializer.fromJson<DateTime?>(json['paidDate']),
      sentDate: serializer.fromJson<DateTime?>(json['sentDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'status': serializer.toJson<String>(status),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'periodStart': serializer.toJson<DateTime?>(periodStart),
      'periodEnd': serializer.toJson<DateTime?>(periodEnd),
      'subtotal': serializer.toJson<double>(subtotal),
      'taxRate': serializer.toJson<double>(taxRate),
      'taxLabel': serializer.toJson<String>(taxLabel),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'lateFeeAmount': serializer.toJson<double>(lateFeeAmount),
      'total': serializer.toJson<double>(total),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'currency': serializer.toJson<String>(currency),
      'notes': serializer.toJson<String?>(notes),
      'templateId': serializer.toJson<int?>(templateId),
      'templateType': serializer.toJson<String>(templateType),
      'pdfPath': serializer.toJson<String?>(pdfPath),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'paidDate': serializer.toJson<DateTime?>(paidDate),
      'sentDate': serializer.toJson<DateTime?>(sentDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Invoice copyWith({
    int? id,
    int? clientId,
    String? invoiceNumber,
    String? status,
    DateTime? issueDate,
    DateTime? dueDate,
    Value<DateTime?> periodStart = const Value.absent(),
    Value<DateTime?> periodEnd = const Value.absent(),
    double? subtotal,
    double? taxRate,
    String? taxLabel,
    double? taxAmount,
    double? lateFeeAmount,
    double? total,
    double? amountPaid,
    String? currency,
    Value<String?> notes = const Value.absent(),
    Value<int?> templateId = const Value.absent(),
    String? templateType,
    Value<String?> pdfPath = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<DateTime?> paidDate = const Value.absent(),
    Value<DateTime?> sentDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Invoice(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    status: status ?? this.status,
    issueDate: issueDate ?? this.issueDate,
    dueDate: dueDate ?? this.dueDate,
    periodStart: periodStart.present ? periodStart.value : this.periodStart,
    periodEnd: periodEnd.present ? periodEnd.value : this.periodEnd,
    subtotal: subtotal ?? this.subtotal,
    taxRate: taxRate ?? this.taxRate,
    taxLabel: taxLabel ?? this.taxLabel,
    taxAmount: taxAmount ?? this.taxAmount,
    lateFeeAmount: lateFeeAmount ?? this.lateFeeAmount,
    total: total ?? this.total,
    amountPaid: amountPaid ?? this.amountPaid,
    currency: currency ?? this.currency,
    notes: notes.present ? notes.value : this.notes,
    templateId: templateId.present ? templateId.value : this.templateId,
    templateType: templateType ?? this.templateType,
    pdfPath: pdfPath.present ? pdfPath.value : this.pdfPath,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    paidDate: paidDate.present ? paidDate.value : this.paidDate,
    sentDate: sentDate.present ? sentDate.value : this.sentDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      status: data.status.present ? data.status.value : this.status,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      periodStart: data.periodStart.present
          ? data.periodStart.value
          : this.periodStart,
      periodEnd: data.periodEnd.present ? data.periodEnd.value : this.periodEnd,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      taxLabel: data.taxLabel.present ? data.taxLabel.value : this.taxLabel,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      lateFeeAmount: data.lateFeeAmount.present
          ? data.lateFeeAmount.value
          : this.lateFeeAmount,
      total: data.total.present ? data.total.value : this.total,
      amountPaid: data.amountPaid.present
          ? data.amountPaid.value
          : this.amountPaid,
      currency: data.currency.present ? data.currency.value : this.currency,
      notes: data.notes.present ? data.notes.value : this.notes,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      templateType: data.templateType.present
          ? data.templateType.value
          : this.templateType,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
      sentDate: data.sentDate.present ? data.sentDate.value : this.sentDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('status: $status, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('subtotal: $subtotal, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxLabel: $taxLabel, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('lateFeeAmount: $lateFeeAmount, ')
          ..write('total: $total, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('templateId: $templateId, ')
          ..write('templateType: $templateType, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paidDate: $paidDate, ')
          ..write('sentDate: $sentDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    clientId,
    invoiceNumber,
    status,
    issueDate,
    dueDate,
    periodStart,
    periodEnd,
    subtotal,
    taxRate,
    taxLabel,
    taxAmount,
    lateFeeAmount,
    total,
    amountPaid,
    currency,
    notes,
    templateId,
    templateType,
    pdfPath,
    paymentMethod,
    paidDate,
    sentDate,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.status == this.status &&
          other.issueDate == this.issueDate &&
          other.dueDate == this.dueDate &&
          other.periodStart == this.periodStart &&
          other.periodEnd == this.periodEnd &&
          other.subtotal == this.subtotal &&
          other.taxRate == this.taxRate &&
          other.taxLabel == this.taxLabel &&
          other.taxAmount == this.taxAmount &&
          other.lateFeeAmount == this.lateFeeAmount &&
          other.total == this.total &&
          other.amountPaid == this.amountPaid &&
          other.currency == this.currency &&
          other.notes == this.notes &&
          other.templateId == this.templateId &&
          other.templateType == this.templateType &&
          other.pdfPath == this.pdfPath &&
          other.paymentMethod == this.paymentMethod &&
          other.paidDate == this.paidDate &&
          other.sentDate == this.sentDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> invoiceNumber;
  final Value<String> status;
  final Value<DateTime> issueDate;
  final Value<DateTime> dueDate;
  final Value<DateTime?> periodStart;
  final Value<DateTime?> periodEnd;
  final Value<double> subtotal;
  final Value<double> taxRate;
  final Value<String> taxLabel;
  final Value<double> taxAmount;
  final Value<double> lateFeeAmount;
  final Value<double> total;
  final Value<double> amountPaid;
  final Value<String> currency;
  final Value<String?> notes;
  final Value<int?> templateId;
  final Value<String> templateType;
  final Value<String?> pdfPath;
  final Value<String?> paymentMethod;
  final Value<DateTime?> paidDate;
  final Value<DateTime?> sentDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxLabel = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.lateFeeAmount = const Value.absent(),
    this.total = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.templateId = const Value.absent(),
    this.templateType = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.sentDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String invoiceNumber,
    this.status = const Value.absent(),
    required DateTime issueDate,
    required DateTime dueDate,
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxLabel = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.lateFeeAmount = const Value.absent(),
    this.total = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.templateId = const Value.absent(),
    this.templateType = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.sentDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       invoiceNumber = Value(invoiceNumber),
       issueDate = Value(issueDate),
       dueDate = Value(dueDate);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? invoiceNumber,
    Expression<String>? status,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? periodStart,
    Expression<DateTime>? periodEnd,
    Expression<double>? subtotal,
    Expression<double>? taxRate,
    Expression<String>? taxLabel,
    Expression<double>? taxAmount,
    Expression<double>? lateFeeAmount,
    Expression<double>? total,
    Expression<double>? amountPaid,
    Expression<String>? currency,
    Expression<String>? notes,
    Expression<int>? templateId,
    Expression<String>? templateType,
    Expression<String>? pdfPath,
    Expression<String>? paymentMethod,
    Expression<DateTime>? paidDate,
    Expression<DateTime>? sentDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (status != null) 'status': status,
      if (issueDate != null) 'issue_date': issueDate,
      if (dueDate != null) 'due_date': dueDate,
      if (periodStart != null) 'period_start': periodStart,
      if (periodEnd != null) 'period_end': periodEnd,
      if (subtotal != null) 'subtotal': subtotal,
      if (taxRate != null) 'tax_rate': taxRate,
      if (taxLabel != null) 'tax_label': taxLabel,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (lateFeeAmount != null) 'late_fee_amount': lateFeeAmount,
      if (total != null) 'total': total,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (currency != null) 'currency': currency,
      if (notes != null) 'notes': notes,
      if (templateId != null) 'template_id': templateId,
      if (templateType != null) 'template_type': templateType,
      if (pdfPath != null) 'pdf_path': pdfPath,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paidDate != null) 'paid_date': paidDate,
      if (sentDate != null) 'sent_date': sentDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<String>? invoiceNumber,
    Value<String>? status,
    Value<DateTime>? issueDate,
    Value<DateTime>? dueDate,
    Value<DateTime?>? periodStart,
    Value<DateTime?>? periodEnd,
    Value<double>? subtotal,
    Value<double>? taxRate,
    Value<String>? taxLabel,
    Value<double>? taxAmount,
    Value<double>? lateFeeAmount,
    Value<double>? total,
    Value<double>? amountPaid,
    Value<String>? currency,
    Value<String?>? notes,
    Value<int?>? templateId,
    Value<String>? templateType,
    Value<String?>? pdfPath,
    Value<String?>? paymentMethod,
    Value<DateTime?>? paidDate,
    Value<DateTime?>? sentDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      status: status ?? this.status,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      subtotal: subtotal ?? this.subtotal,
      taxRate: taxRate ?? this.taxRate,
      taxLabel: taxLabel ?? this.taxLabel,
      taxAmount: taxAmount ?? this.taxAmount,
      lateFeeAmount: lateFeeAmount ?? this.lateFeeAmount,
      total: total ?? this.total,
      amountPaid: amountPaid ?? this.amountPaid,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      templateId: templateId ?? this.templateId,
      templateType: templateType ?? this.templateType,
      pdfPath: pdfPath ?? this.pdfPath,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidDate: paidDate ?? this.paidDate,
      sentDate: sentDate ?? this.sentDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<DateTime>(periodStart.value);
    }
    if (periodEnd.present) {
      map['period_end'] = Variable<DateTime>(periodEnd.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    if (taxLabel.present) {
      map['tax_label'] = Variable<String>(taxLabel.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (lateFeeAmount.present) {
      map['late_fee_amount'] = Variable<double>(lateFeeAmount.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (templateType.present) {
      map['template_type'] = Variable<String>(templateType.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<DateTime>(paidDate.value);
    }
    if (sentDate.present) {
      map['sent_date'] = Variable<DateTime>(sentDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('status: $status, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('subtotal: $subtotal, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxLabel: $taxLabel, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('lateFeeAmount: $lateFeeAmount, ')
          ..write('total: $total, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('templateId: $templateId, ')
          ..write('templateType: $templateType, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paidDate: $paidDate, ')
          ..write('sentDate: $sentDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TimeEntriesTable extends TimeEntries
    with TableInfo<$TimeEntriesTable, TimeEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issueReferenceMeta = const VerificationMeta(
    'issueReference',
  );
  @override
  late final GeneratedColumn<String> issueReference = GeneratedColumn<String>(
    'issue_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repositoryMeta = const VerificationMeta(
    'repository',
  );
  @override
  late final GeneratedColumn<String> repository = GeneratedColumn<String>(
    'repository',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isManualMeta = const VerificationMeta(
    'isManual',
  );
  @override
  late final GeneratedColumn<bool> isManual = GeneratedColumn<bool>(
    'is_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hourlyRateSnapshotMeta =
      const VerificationMeta('hourlyRateSnapshot');
  @override
  late final GeneratedColumn<double> hourlyRateSnapshot =
      GeneratedColumn<double>(
        'hourly_rate_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isInvoicedMeta = const VerificationMeta(
    'isInvoiced',
  );
  @override
  late final GeneratedColumn<bool> isInvoiced = GeneratedColumn<bool>(
    'is_invoiced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_invoiced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    projectId,
    startTime,
    endTime,
    durationMinutes,
    description,
    issueReference,
    repository,
    tags,
    isManual,
    hourlyRateSnapshot,
    isInvoiced,
    invoiceId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('issue_reference')) {
      context.handle(
        _issueReferenceMeta,
        issueReference.isAcceptableOrUnknown(
          data['issue_reference']!,
          _issueReferenceMeta,
        ),
      );
    }
    if (data.containsKey('repository')) {
      context.handle(
        _repositoryMeta,
        repository.isAcceptableOrUnknown(data['repository']!, _repositoryMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('is_manual')) {
      context.handle(
        _isManualMeta,
        isManual.isAcceptableOrUnknown(data['is_manual']!, _isManualMeta),
      );
    }
    if (data.containsKey('hourly_rate_snapshot')) {
      context.handle(
        _hourlyRateSnapshotMeta,
        hourlyRateSnapshot.isAcceptableOrUnknown(
          data['hourly_rate_snapshot']!,
          _hourlyRateSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hourlyRateSnapshotMeta);
    }
    if (data.containsKey('is_invoiced')) {
      context.handle(
        _isInvoicedMeta,
        isInvoiced.isAcceptableOrUnknown(data['is_invoiced']!, _isInvoicedMeta),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      issueReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issue_reference'],
      ),
      repository: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repository'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      isManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual'],
      )!,
      hourlyRateSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate_snapshot'],
      )!,
      isInvoiced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_invoiced'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TimeEntriesTable createAlias(String alias) {
    return $TimeEntriesTable(attachedDatabase, alias);
  }
}

class TimeEntry extends DataClass implements Insertable<TimeEntry> {
  final int id;
  final int clientId;
  final int? projectId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final String? description;
  final String? issueReference;
  final String? repository;
  final String? tags;
  final bool isManual;
  final double hourlyRateSnapshot;
  final bool isInvoiced;
  final int? invoiceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TimeEntry({
    required this.id,
    required this.clientId,
    this.projectId,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    this.description,
    this.issueReference,
    this.repository,
    this.tags,
    required this.isManual,
    required this.hourlyRateSnapshot,
    required this.isInvoiced,
    this.invoiceId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || issueReference != null) {
      map['issue_reference'] = Variable<String>(issueReference);
    }
    if (!nullToAbsent || repository != null) {
      map['repository'] = Variable<String>(repository);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['is_manual'] = Variable<bool>(isManual);
    map['hourly_rate_snapshot'] = Variable<double>(hourlyRateSnapshot);
    map['is_invoiced'] = Variable<bool>(isInvoiced);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TimeEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimeEntriesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      issueReference: issueReference == null && nullToAbsent
          ? const Value.absent()
          : Value(issueReference),
      repository: repository == null && nullToAbsent
          ? const Value.absent()
          : Value(repository),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      isManual: Value(isManual),
      hourlyRateSnapshot: Value(hourlyRateSnapshot),
      isInvoiced: Value(isInvoiced),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TimeEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeEntry(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      projectId: serializer.fromJson<int?>(json['projectId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      description: serializer.fromJson<String?>(json['description']),
      issueReference: serializer.fromJson<String?>(json['issueReference']),
      repository: serializer.fromJson<String?>(json['repository']),
      tags: serializer.fromJson<String?>(json['tags']),
      isManual: serializer.fromJson<bool>(json['isManual']),
      hourlyRateSnapshot: serializer.fromJson<double>(
        json['hourlyRateSnapshot'],
      ),
      isInvoiced: serializer.fromJson<bool>(json['isInvoiced']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'projectId': serializer.toJson<int?>(projectId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'description': serializer.toJson<String?>(description),
      'issueReference': serializer.toJson<String?>(issueReference),
      'repository': serializer.toJson<String?>(repository),
      'tags': serializer.toJson<String?>(tags),
      'isManual': serializer.toJson<bool>(isManual),
      'hourlyRateSnapshot': serializer.toJson<double>(hourlyRateSnapshot),
      'isInvoiced': serializer.toJson<bool>(isInvoiced),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TimeEntry copyWith({
    int? id,
    int? clientId,
    Value<int?> projectId = const Value.absent(),
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> issueReference = const Value.absent(),
    Value<String?> repository = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    bool? isManual,
    double? hourlyRateSnapshot,
    bool? isInvoiced,
    Value<int?> invoiceId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TimeEntry(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    projectId: projectId.present ? projectId.value : this.projectId,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    description: description.present ? description.value : this.description,
    issueReference: issueReference.present
        ? issueReference.value
        : this.issueReference,
    repository: repository.present ? repository.value : this.repository,
    tags: tags.present ? tags.value : this.tags,
    isManual: isManual ?? this.isManual,
    hourlyRateSnapshot: hourlyRateSnapshot ?? this.hourlyRateSnapshot,
    isInvoiced: isInvoiced ?? this.isInvoiced,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TimeEntry copyWithCompanion(TimeEntriesCompanion data) {
    return TimeEntry(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      description: data.description.present
          ? data.description.value
          : this.description,
      issueReference: data.issueReference.present
          ? data.issueReference.value
          : this.issueReference,
      repository: data.repository.present
          ? data.repository.value
          : this.repository,
      tags: data.tags.present ? data.tags.value : this.tags,
      isManual: data.isManual.present ? data.isManual.value : this.isManual,
      hourlyRateSnapshot: data.hourlyRateSnapshot.present
          ? data.hourlyRateSnapshot.value
          : this.hourlyRateSnapshot,
      isInvoiced: data.isInvoiced.present
          ? data.isInvoiced.value
          : this.isInvoiced,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntry(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('projectId: $projectId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('description: $description, ')
          ..write('issueReference: $issueReference, ')
          ..write('repository: $repository, ')
          ..write('tags: $tags, ')
          ..write('isManual: $isManual, ')
          ..write('hourlyRateSnapshot: $hourlyRateSnapshot, ')
          ..write('isInvoiced: $isInvoiced, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    projectId,
    startTime,
    endTime,
    durationMinutes,
    description,
    issueReference,
    repository,
    tags,
    isManual,
    hourlyRateSnapshot,
    isInvoiced,
    invoiceId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeEntry &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.projectId == this.projectId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationMinutes == this.durationMinutes &&
          other.description == this.description &&
          other.issueReference == this.issueReference &&
          other.repository == this.repository &&
          other.tags == this.tags &&
          other.isManual == this.isManual &&
          other.hourlyRateSnapshot == this.hourlyRateSnapshot &&
          other.isInvoiced == this.isInvoiced &&
          other.invoiceId == this.invoiceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TimeEntriesCompanion extends UpdateCompanion<TimeEntry> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<int?> projectId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> durationMinutes;
  final Value<String?> description;
  final Value<String?> issueReference;
  final Value<String?> repository;
  final Value<String?> tags;
  final Value<bool> isManual;
  final Value<double> hourlyRateSnapshot;
  final Value<bool> isInvoiced;
  final Value<int?> invoiceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TimeEntriesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.description = const Value.absent(),
    this.issueReference = const Value.absent(),
    this.repository = const Value.absent(),
    this.tags = const Value.absent(),
    this.isManual = const Value.absent(),
    this.hourlyRateSnapshot = const Value.absent(),
    this.isInvoiced = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TimeEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    this.projectId = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.description = const Value.absent(),
    this.issueReference = const Value.absent(),
    this.repository = const Value.absent(),
    this.tags = const Value.absent(),
    this.isManual = const Value.absent(),
    required double hourlyRateSnapshot,
    this.isInvoiced = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       startTime = Value(startTime),
       hourlyRateSnapshot = Value(hourlyRateSnapshot);
  static Insertable<TimeEntry> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<int>? projectId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationMinutes,
    Expression<String>? description,
    Expression<String>? issueReference,
    Expression<String>? repository,
    Expression<String>? tags,
    Expression<bool>? isManual,
    Expression<double>? hourlyRateSnapshot,
    Expression<bool>? isInvoiced,
    Expression<int>? invoiceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (projectId != null) 'project_id': projectId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (description != null) 'description': description,
      if (issueReference != null) 'issue_reference': issueReference,
      if (repository != null) 'repository': repository,
      if (tags != null) 'tags': tags,
      if (isManual != null) 'is_manual': isManual,
      if (hourlyRateSnapshot != null)
        'hourly_rate_snapshot': hourlyRateSnapshot,
      if (isInvoiced != null) 'is_invoiced': isInvoiced,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TimeEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<int?>? projectId,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<int?>? durationMinutes,
    Value<String?>? description,
    Value<String?>? issueReference,
    Value<String?>? repository,
    Value<String?>? tags,
    Value<bool>? isManual,
    Value<double>? hourlyRateSnapshot,
    Value<bool>? isInvoiced,
    Value<int?>? invoiceId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TimeEntriesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      projectId: projectId ?? this.projectId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      description: description ?? this.description,
      issueReference: issueReference ?? this.issueReference,
      repository: repository ?? this.repository,
      tags: tags ?? this.tags,
      isManual: isManual ?? this.isManual,
      hourlyRateSnapshot: hourlyRateSnapshot ?? this.hourlyRateSnapshot,
      isInvoiced: isInvoiced ?? this.isInvoiced,
      invoiceId: invoiceId ?? this.invoiceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (issueReference.present) {
      map['issue_reference'] = Variable<String>(issueReference.value);
    }
    if (repository.present) {
      map['repository'] = Variable<String>(repository.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (isManual.present) {
      map['is_manual'] = Variable<bool>(isManual.value);
    }
    if (hourlyRateSnapshot.present) {
      map['hourly_rate_snapshot'] = Variable<double>(hourlyRateSnapshot.value);
    }
    if (isInvoiced.present) {
      map['is_invoiced'] = Variable<bool>(isInvoiced.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('projectId: $projectId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('description: $description, ')
          ..write('issueReference: $issueReference, ')
          ..write('repository: $repository, ')
          ..write('tags: $tags, ')
          ..write('isManual: $isManual, ')
          ..write('hourlyRateSnapshot: $hourlyRateSnapshot, ')
          ..write('isInvoiced: $isInvoiced, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InvoiceLineItemsTable extends InvoiceLineItems
    with TableInfo<$InvoiceLineItemsTable, InvoiceLineItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceLineItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeEntryIdMeta = const VerificationMeta(
    'timeEntryId',
  );
  @override
  late final GeneratedColumn<int> timeEntryId = GeneratedColumn<int>(
    'time_entry_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES time_entries (id)',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    sortOrder,
    description,
    quantity,
    unitPrice,
    total,
    timeEntryId,
    projectId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_line_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceLineItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('time_entry_id')) {
      context.handle(
        _timeEntryIdMeta,
        timeEntryId.isAcceptableOrUnknown(
          data['time_entry_id']!,
          _timeEntryIdMeta,
        ),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceLineItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceLineItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      timeEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_entry_id'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoiceLineItemsTable createAlias(String alias) {
    return $InvoiceLineItemsTable(attachedDatabase, alias);
  }
}

class InvoiceLineItem extends DataClass implements Insertable<InvoiceLineItem> {
  final int id;
  final int invoiceId;
  final int sortOrder;
  final String description;
  final double quantity;
  final double unitPrice;
  final double total;
  final int? timeEntryId;
  final int? projectId;
  final DateTime createdAt;
  const InvoiceLineItem({
    required this.id,
    required this.invoiceId,
    required this.sortOrder,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    this.timeEntryId,
    this.projectId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || timeEntryId != null) {
      map['time_entry_id'] = Variable<int>(timeEntryId);
    }
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<int>(projectId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoiceLineItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceLineItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      sortOrder: Value(sortOrder),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      total: Value(total),
      timeEntryId: timeEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(timeEntryId),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      createdAt: Value(createdAt),
    );
  }

  factory InvoiceLineItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceLineItem(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      total: serializer.fromJson<double>(json['total']),
      timeEntryId: serializer.fromJson<int?>(json['timeEntryId']),
      projectId: serializer.fromJson<int?>(json['projectId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'total': serializer.toJson<double>(total),
      'timeEntryId': serializer.toJson<int?>(timeEntryId),
      'projectId': serializer.toJson<int?>(projectId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InvoiceLineItem copyWith({
    int? id,
    int? invoiceId,
    int? sortOrder,
    String? description,
    double? quantity,
    double? unitPrice,
    double? total,
    Value<int?> timeEntryId = const Value.absent(),
    Value<int?> projectId = const Value.absent(),
    DateTime? createdAt,
  }) => InvoiceLineItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    sortOrder: sortOrder ?? this.sortOrder,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    total: total ?? this.total,
    timeEntryId: timeEntryId.present ? timeEntryId.value : this.timeEntryId,
    projectId: projectId.present ? projectId.value : this.projectId,
    createdAt: createdAt ?? this.createdAt,
  );
  InvoiceLineItem copyWithCompanion(InvoiceLineItemsCompanion data) {
    return InvoiceLineItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
      timeEntryId: data.timeEntryId.present
          ? data.timeEntryId.value
          : this.timeEntryId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceLineItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('timeEntryId: $timeEntryId, ')
          ..write('projectId: $projectId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    sortOrder,
    description,
    quantity,
    unitPrice,
    total,
    timeEntryId,
    projectId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceLineItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.sortOrder == this.sortOrder &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total &&
          other.timeEntryId == this.timeEntryId &&
          other.projectId == this.projectId &&
          other.createdAt == this.createdAt);
}

class InvoiceLineItemsCompanion extends UpdateCompanion<InvoiceLineItem> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> sortOrder;
  final Value<String> description;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> total;
  final Value<int?> timeEntryId;
  final Value<int?> projectId;
  final Value<DateTime> createdAt;
  const InvoiceLineItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.timeEntryId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoiceLineItemsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    this.sortOrder = const Value.absent(),
    required String description,
    required double quantity,
    required double unitPrice,
    required double total,
    this.timeEntryId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       description = Value(description),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       total = Value(total);
  static Insertable<InvoiceLineItem> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? sortOrder,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? total,
    Expression<int>? timeEntryId,
    Expression<int>? projectId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (timeEntryId != null) 'time_entry_id': timeEntryId,
      if (projectId != null) 'project_id': projectId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoiceLineItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? sortOrder,
    Value<String>? description,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<double>? total,
    Value<int?>? timeEntryId,
    Value<int?>? projectId,
    Value<DateTime>? createdAt,
  }) {
    return InvoiceLineItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      sortOrder: sortOrder ?? this.sortOrder,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      timeEntryId: timeEntryId ?? this.timeEntryId,
      projectId: projectId ?? this.projectId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (timeEntryId.present) {
      map['time_entry_id'] = Variable<int>(timeEntryId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceLineItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('timeEntryId: $timeEntryId, ')
          ..write('projectId: $projectId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppSetting(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $InvoiceTemplatesTable invoiceTemplates = $InvoiceTemplatesTable(
    this,
  );
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $TimeEntriesTable timeEntries = $TimeEntriesTable(this);
  late final $InvoiceLineItemsTable invoiceLineItems = $InvoiceLineItemsTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    invoiceTemplates,
    userProfiles,
    clients,
    projects,
    invoices,
    timeEntries,
    invoiceLineItems,
    appSettings,
  ];
}

typedef $$InvoiceTemplatesTableCreateCompanionBuilder =
    InvoiceTemplatesCompanion Function({
      Value<int> id,
      required String name,
      required String templateKey,
      Value<String?> description,
      Value<bool> isDefault,
      Value<int> primaryColor,
      Value<int> accentColor,
      Value<String> fontFamily,
      Value<bool> showLogo,
      Value<bool> showPaymentInfo,
      Value<bool> showTaxBreakdown,
      Value<bool> showTaxId,
      Value<bool> showBusinessLicense,
      Value<bool> showBankDetails,
      Value<bool> showStripeLink,
      Value<bool> showDetailedBreakdown,
      Value<bool> showPaymentTerms,
      Value<bool> showLateFeeClause,
      Value<String?> footerText,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$InvoiceTemplatesTableUpdateCompanionBuilder =
    InvoiceTemplatesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> templateKey,
      Value<String?> description,
      Value<bool> isDefault,
      Value<int> primaryColor,
      Value<int> accentColor,
      Value<String> fontFamily,
      Value<bool> showLogo,
      Value<bool> showPaymentInfo,
      Value<bool> showTaxBreakdown,
      Value<bool> showTaxId,
      Value<bool> showBusinessLicense,
      Value<bool> showBankDetails,
      Value<bool> showStripeLink,
      Value<bool> showDetailedBreakdown,
      Value<bool> showPaymentTerms,
      Value<bool> showLateFeeClause,
      Value<String?> footerText,
      Value<bool> isBuiltIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$InvoiceTemplatesTableReferences
    extends
        BaseReferences<_$AppDatabase, $InvoiceTemplatesTable, InvoiceTemplate> {
  $$InvoiceTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserProfilesTable, List<UserProfile>>
  _userProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userProfiles,
    aliasName: $_aliasNameGenerator(
      db.invoiceTemplates.id,
      db.userProfiles.defaultTemplateId,
    ),
  );

  $$UserProfilesTableProcessedTableManager get userProfilesRefs {
    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.defaultTemplateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userProfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ClientsTable, List<Client>> _clientsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.clients,
    aliasName: $_aliasNameGenerator(
      db.invoiceTemplates.id,
      db.clients.defaultTemplateId,
    ),
  );

  $$ClientsTableProcessedTableManager get clientsRefs {
    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.defaultTemplateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_clientsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(
      db.invoiceTemplates.id,
      db.invoices.templateId,
    ),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoiceTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceTemplatesTable> {
  $$InvoiceTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showLogo => $composableBuilder(
    column: $table.showLogo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showPaymentInfo => $composableBuilder(
    column: $table.showPaymentInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showTaxBreakdown => $composableBuilder(
    column: $table.showTaxBreakdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showTaxId => $composableBuilder(
    column: $table.showTaxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showBusinessLicense => $composableBuilder(
    column: $table.showBusinessLicense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showBankDetails => $composableBuilder(
    column: $table.showBankDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showStripeLink => $composableBuilder(
    column: $table.showStripeLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showDetailedBreakdown => $composableBuilder(
    column: $table.showDetailedBreakdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showPaymentTerms => $composableBuilder(
    column: $table.showPaymentTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showLateFeeClause => $composableBuilder(
    column: $table.showLateFeeClause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get footerText => $composableBuilder(
    column: $table.footerText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userProfilesRefs(
    Expression<bool> Function($$UserProfilesTableFilterComposer f) f,
  ) {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.defaultTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> clientsRefs(
    Expression<bool> Function($$ClientsTableFilterComposer f) f,
  ) {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.defaultTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoiceTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceTemplatesTable> {
  $$InvoiceTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showLogo => $composableBuilder(
    column: $table.showLogo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showPaymentInfo => $composableBuilder(
    column: $table.showPaymentInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showTaxBreakdown => $composableBuilder(
    column: $table.showTaxBreakdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showTaxId => $composableBuilder(
    column: $table.showTaxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showBusinessLicense => $composableBuilder(
    column: $table.showBusinessLicense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showBankDetails => $composableBuilder(
    column: $table.showBankDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showStripeLink => $composableBuilder(
    column: $table.showStripeLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showDetailedBreakdown => $composableBuilder(
    column: $table.showDetailedBreakdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showPaymentTerms => $composableBuilder(
    column: $table.showPaymentTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showLateFeeClause => $composableBuilder(
    column: $table.showLateFeeClause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get footerText => $composableBuilder(
    column: $table.footerText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoiceTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceTemplatesTable> {
  $$InvoiceTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<int> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showLogo =>
      $composableBuilder(column: $table.showLogo, builder: (column) => column);

  GeneratedColumn<bool> get showPaymentInfo => $composableBuilder(
    column: $table.showPaymentInfo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showTaxBreakdown => $composableBuilder(
    column: $table.showTaxBreakdown,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showTaxId =>
      $composableBuilder(column: $table.showTaxId, builder: (column) => column);

  GeneratedColumn<bool> get showBusinessLicense => $composableBuilder(
    column: $table.showBusinessLicense,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showBankDetails => $composableBuilder(
    column: $table.showBankDetails,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showStripeLink => $composableBuilder(
    column: $table.showStripeLink,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showDetailedBreakdown => $composableBuilder(
    column: $table.showDetailedBreakdown,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showPaymentTerms => $composableBuilder(
    column: $table.showPaymentTerms,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showLateFeeClause => $composableBuilder(
    column: $table.showLateFeeClause,
    builder: (column) => column,
  );

  GeneratedColumn<String> get footerText => $composableBuilder(
    column: $table.footerText,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> userProfilesRefs<T extends Object>(
    Expression<T> Function($$UserProfilesTableAnnotationComposer a) f,
  ) {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.defaultTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> clientsRefs<T extends Object>(
    Expression<T> Function($$ClientsTableAnnotationComposer a) f,
  ) {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.defaultTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoiceTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceTemplatesTable,
          InvoiceTemplate,
          $$InvoiceTemplatesTableFilterComposer,
          $$InvoiceTemplatesTableOrderingComposer,
          $$InvoiceTemplatesTableAnnotationComposer,
          $$InvoiceTemplatesTableCreateCompanionBuilder,
          $$InvoiceTemplatesTableUpdateCompanionBuilder,
          (InvoiceTemplate, $$InvoiceTemplatesTableReferences),
          InvoiceTemplate,
          PrefetchHooks Function({
            bool userProfilesRefs,
            bool clientsRefs,
            bool invoicesRefs,
          })
        > {
  $$InvoiceTemplatesTableTableManager(
    _$AppDatabase db,
    $InvoiceTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> templateKey = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> primaryColor = const Value.absent(),
                Value<int> accentColor = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<bool> showLogo = const Value.absent(),
                Value<bool> showPaymentInfo = const Value.absent(),
                Value<bool> showTaxBreakdown = const Value.absent(),
                Value<bool> showTaxId = const Value.absent(),
                Value<bool> showBusinessLicense = const Value.absent(),
                Value<bool> showBankDetails = const Value.absent(),
                Value<bool> showStripeLink = const Value.absent(),
                Value<bool> showDetailedBreakdown = const Value.absent(),
                Value<bool> showPaymentTerms = const Value.absent(),
                Value<bool> showLateFeeClause = const Value.absent(),
                Value<String?> footerText = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InvoiceTemplatesCompanion(
                id: id,
                name: name,
                templateKey: templateKey,
                description: description,
                isDefault: isDefault,
                primaryColor: primaryColor,
                accentColor: accentColor,
                fontFamily: fontFamily,
                showLogo: showLogo,
                showPaymentInfo: showPaymentInfo,
                showTaxBreakdown: showTaxBreakdown,
                showTaxId: showTaxId,
                showBusinessLicense: showBusinessLicense,
                showBankDetails: showBankDetails,
                showStripeLink: showStripeLink,
                showDetailedBreakdown: showDetailedBreakdown,
                showPaymentTerms: showPaymentTerms,
                showLateFeeClause: showLateFeeClause,
                footerText: footerText,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String templateKey,
                Value<String?> description = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> primaryColor = const Value.absent(),
                Value<int> accentColor = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<bool> showLogo = const Value.absent(),
                Value<bool> showPaymentInfo = const Value.absent(),
                Value<bool> showTaxBreakdown = const Value.absent(),
                Value<bool> showTaxId = const Value.absent(),
                Value<bool> showBusinessLicense = const Value.absent(),
                Value<bool> showBankDetails = const Value.absent(),
                Value<bool> showStripeLink = const Value.absent(),
                Value<bool> showDetailedBreakdown = const Value.absent(),
                Value<bool> showPaymentTerms = const Value.absent(),
                Value<bool> showLateFeeClause = const Value.absent(),
                Value<String?> footerText = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InvoiceTemplatesCompanion.insert(
                id: id,
                name: name,
                templateKey: templateKey,
                description: description,
                isDefault: isDefault,
                primaryColor: primaryColor,
                accentColor: accentColor,
                fontFamily: fontFamily,
                showLogo: showLogo,
                showPaymentInfo: showPaymentInfo,
                showTaxBreakdown: showTaxBreakdown,
                showTaxId: showTaxId,
                showBusinessLicense: showBusinessLicense,
                showBankDetails: showBankDetails,
                showStripeLink: showStripeLink,
                showDetailedBreakdown: showDetailedBreakdown,
                showPaymentTerms: showPaymentTerms,
                showLateFeeClause: showLateFeeClause,
                footerText: footerText,
                isBuiltIn: isBuiltIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userProfilesRefs = false,
                clientsRefs = false,
                invoicesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userProfilesRefs) db.userProfiles,
                    if (clientsRefs) db.clients,
                    if (invoicesRefs) db.invoices,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userProfilesRefs)
                        await $_getPrefetchedData<
                          InvoiceTemplate,
                          $InvoiceTemplatesTable,
                          UserProfile
                        >(
                          currentTable: table,
                          referencedTable: $$InvoiceTemplatesTableReferences
                              ._userProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoiceTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).userProfilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultTemplateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (clientsRefs)
                        await $_getPrefetchedData<
                          InvoiceTemplate,
                          $InvoiceTemplatesTable,
                          Client
                        >(
                          currentTable: table,
                          referencedTable: $$InvoiceTemplatesTableReferences
                              ._clientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoiceTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).clientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultTemplateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          InvoiceTemplate,
                          $InvoiceTemplatesTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$InvoiceTemplatesTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoiceTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoiceTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceTemplatesTable,
      InvoiceTemplate,
      $$InvoiceTemplatesTableFilterComposer,
      $$InvoiceTemplatesTableOrderingComposer,
      $$InvoiceTemplatesTableAnnotationComposer,
      $$InvoiceTemplatesTableCreateCompanionBuilder,
      $$InvoiceTemplatesTableUpdateCompanionBuilder,
      (InvoiceTemplate, $$InvoiceTemplatesTableReferences),
      InvoiceTemplate,
      PrefetchHooks Function({
        bool userProfilesRefs,
        bool clientsRefs,
        bool invoicesRefs,
      })
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> businessName,
      Value<String> ownerName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> addressLine1,
      Value<String?> addressLine2,
      Value<String?> city,
      Value<String?> stateProvince,
      Value<String?> postalCode,
      Value<String?> country,
      Value<String?> taxId,
      Value<bool> showTaxId,
      Value<String?> waBusinessLicense,
      Value<bool> showWaLicense,
      Value<String?> logoPath,
      Value<String?> bankName,
      Value<String?> bankAccountName,
      Value<String?> bankAccountNumber,
      Value<String?> bankRoutingNumber,
      Value<String> bankAccountType,
      Value<String?> bankSwift,
      Value<String?> bankIban,
      Value<bool> showBankDetails,
      Value<String?> stripePaymentLink,
      Value<bool> showStripeLink,
      Value<String?> paymentInstructions,
      Value<String> defaultCurrency,
      Value<double> defaultHourlyRate,
      Value<String> defaultTaxLabel,
      Value<double> defaultTaxRate,
      Value<String> defaultPaymentTerms,
      Value<int> defaultPaymentTermsDays,
      Value<double?> lateFeePercentage,
      Value<int?> defaultTemplateId,
      Value<String> defaultEmailSubjectFormat,
      Value<int> nextInvoiceNumber,
      Value<String> invoiceNumberPrefix,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> businessName,
      Value<String> ownerName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> addressLine1,
      Value<String?> addressLine2,
      Value<String?> city,
      Value<String?> stateProvince,
      Value<String?> postalCode,
      Value<String?> country,
      Value<String?> taxId,
      Value<bool> showTaxId,
      Value<String?> waBusinessLicense,
      Value<bool> showWaLicense,
      Value<String?> logoPath,
      Value<String?> bankName,
      Value<String?> bankAccountName,
      Value<String?> bankAccountNumber,
      Value<String?> bankRoutingNumber,
      Value<String> bankAccountType,
      Value<String?> bankSwift,
      Value<String?> bankIban,
      Value<bool> showBankDetails,
      Value<String?> stripePaymentLink,
      Value<bool> showStripeLink,
      Value<String?> paymentInstructions,
      Value<String> defaultCurrency,
      Value<double> defaultHourlyRate,
      Value<String> defaultTaxLabel,
      Value<double> defaultTaxRate,
      Value<String> defaultPaymentTerms,
      Value<int> defaultPaymentTermsDays,
      Value<double?> lateFeePercentage,
      Value<int?> defaultTemplateId,
      Value<String> defaultEmailSubjectFormat,
      Value<int> nextInvoiceNumber,
      Value<String> invoiceNumberPrefix,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile> {
  $$UserProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoiceTemplatesTable _defaultTemplateIdTable(_$AppDatabase db) =>
      db.invoiceTemplates.createAlias(
        $_aliasNameGenerator(
          db.userProfiles.defaultTemplateId,
          db.invoiceTemplates.id,
        ),
      );

  $$InvoiceTemplatesTableProcessedTableManager? get defaultTemplateId {
    final $_column = $_itemColumn<int>('default_template_id');
    if ($_column == null) return null;
    final manager = $$InvoiceTemplatesTableTableManager(
      $_db,
      $_db.invoiceTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultTemplateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showTaxId => $composableBuilder(
    column: $table.showTaxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get waBusinessLicense => $composableBuilder(
    column: $table.waBusinessLicense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showWaLicense => $composableBuilder(
    column: $table.showWaLicense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankAccountName => $composableBuilder(
    column: $table.bankAccountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankAccountNumber => $composableBuilder(
    column: $table.bankAccountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankRoutingNumber => $composableBuilder(
    column: $table.bankRoutingNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankAccountType => $composableBuilder(
    column: $table.bankAccountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankSwift => $composableBuilder(
    column: $table.bankSwift,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankIban => $composableBuilder(
    column: $table.bankIban,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showBankDetails => $composableBuilder(
    column: $table.showBankDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stripePaymentLink => $composableBuilder(
    column: $table.stripePaymentLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showStripeLink => $composableBuilder(
    column: $table.showStripeLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultTaxLabel => $composableBuilder(
    column: $table.defaultTaxLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultTaxRate => $composableBuilder(
    column: $table.defaultTaxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultPaymentTerms => $composableBuilder(
    column: $table.defaultPaymentTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultPaymentTermsDays => $composableBuilder(
    column: $table.defaultPaymentTermsDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lateFeePercentage => $composableBuilder(
    column: $table.lateFeePercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultEmailSubjectFormat => $composableBuilder(
    column: $table.defaultEmailSubjectFormat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextInvoiceNumber => $composableBuilder(
    column: $table.nextInvoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumberPrefix => $composableBuilder(
    column: $table.invoiceNumberPrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoiceTemplatesTableFilterComposer get defaultTemplateId {
    final $$InvoiceTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultTemplateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showTaxId => $composableBuilder(
    column: $table.showTaxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get waBusinessLicense => $composableBuilder(
    column: $table.waBusinessLicense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showWaLicense => $composableBuilder(
    column: $table.showWaLicense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankAccountName => $composableBuilder(
    column: $table.bankAccountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankAccountNumber => $composableBuilder(
    column: $table.bankAccountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankRoutingNumber => $composableBuilder(
    column: $table.bankRoutingNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankAccountType => $composableBuilder(
    column: $table.bankAccountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankSwift => $composableBuilder(
    column: $table.bankSwift,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankIban => $composableBuilder(
    column: $table.bankIban,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showBankDetails => $composableBuilder(
    column: $table.showBankDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stripePaymentLink => $composableBuilder(
    column: $table.stripePaymentLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showStripeLink => $composableBuilder(
    column: $table.showStripeLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultTaxLabel => $composableBuilder(
    column: $table.defaultTaxLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultTaxRate => $composableBuilder(
    column: $table.defaultTaxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultPaymentTerms => $composableBuilder(
    column: $table.defaultPaymentTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultPaymentTermsDays => $composableBuilder(
    column: $table.defaultPaymentTermsDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lateFeePercentage => $composableBuilder(
    column: $table.lateFeePercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultEmailSubjectFormat => $composableBuilder(
    column: $table.defaultEmailSubjectFormat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextInvoiceNumber => $composableBuilder(
    column: $table.nextInvoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumberPrefix => $composableBuilder(
    column: $table.invoiceNumberPrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoiceTemplatesTableOrderingComposer get defaultTemplateId {
    final $$InvoiceTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultTemplateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => column,
  );

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get taxId =>
      $composableBuilder(column: $table.taxId, builder: (column) => column);

  GeneratedColumn<bool> get showTaxId =>
      $composableBuilder(column: $table.showTaxId, builder: (column) => column);

  GeneratedColumn<String> get waBusinessLicense => $composableBuilder(
    column: $table.waBusinessLicense,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showWaLicense => $composableBuilder(
    column: $table.showWaLicense,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get bankAccountName => $composableBuilder(
    column: $table.bankAccountName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankAccountNumber => $composableBuilder(
    column: $table.bankAccountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankRoutingNumber => $composableBuilder(
    column: $table.bankRoutingNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankAccountType => $composableBuilder(
    column: $table.bankAccountType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankSwift =>
      $composableBuilder(column: $table.bankSwift, builder: (column) => column);

  GeneratedColumn<String> get bankIban =>
      $composableBuilder(column: $table.bankIban, builder: (column) => column);

  GeneratedColumn<bool> get showBankDetails => $composableBuilder(
    column: $table.showBankDetails,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stripePaymentLink => $composableBuilder(
    column: $table.stripePaymentLink,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showStripeLink => $composableBuilder(
    column: $table.showStripeLink,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultTaxLabel => $composableBuilder(
    column: $table.defaultTaxLabel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultTaxRate => $composableBuilder(
    column: $table.defaultTaxRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultPaymentTerms => $composableBuilder(
    column: $table.defaultPaymentTerms,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultPaymentTermsDays => $composableBuilder(
    column: $table.defaultPaymentTermsDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lateFeePercentage => $composableBuilder(
    column: $table.lateFeePercentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultEmailSubjectFormat => $composableBuilder(
    column: $table.defaultEmailSubjectFormat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextInvoiceNumber => $composableBuilder(
    column: $table.nextInvoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceNumberPrefix => $composableBuilder(
    column: $table.invoiceNumberPrefix,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$InvoiceTemplatesTableAnnotationComposer get defaultTemplateId {
    final $$InvoiceTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultTemplateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (UserProfile, $$UserProfilesTableReferences),
          UserProfile,
          PrefetchHooks Function({bool defaultTemplateId})
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> addressLine1 = const Value.absent(),
                Value<String?> addressLine2 = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> stateProvince = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<bool> showTaxId = const Value.absent(),
                Value<String?> waBusinessLicense = const Value.absent(),
                Value<bool> showWaLicense = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> bankAccountName = const Value.absent(),
                Value<String?> bankAccountNumber = const Value.absent(),
                Value<String?> bankRoutingNumber = const Value.absent(),
                Value<String> bankAccountType = const Value.absent(),
                Value<String?> bankSwift = const Value.absent(),
                Value<String?> bankIban = const Value.absent(),
                Value<bool> showBankDetails = const Value.absent(),
                Value<String?> stripePaymentLink = const Value.absent(),
                Value<bool> showStripeLink = const Value.absent(),
                Value<String?> paymentInstructions = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<double> defaultHourlyRate = const Value.absent(),
                Value<String> defaultTaxLabel = const Value.absent(),
                Value<double> defaultTaxRate = const Value.absent(),
                Value<String> defaultPaymentTerms = const Value.absent(),
                Value<int> defaultPaymentTermsDays = const Value.absent(),
                Value<double?> lateFeePercentage = const Value.absent(),
                Value<int?> defaultTemplateId = const Value.absent(),
                Value<String> defaultEmailSubjectFormat = const Value.absent(),
                Value<int> nextInvoiceNumber = const Value.absent(),
                Value<String> invoiceNumberPrefix = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                businessName: businessName,
                ownerName: ownerName,
                email: email,
                phone: phone,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                stateProvince: stateProvince,
                postalCode: postalCode,
                country: country,
                taxId: taxId,
                showTaxId: showTaxId,
                waBusinessLicense: waBusinessLicense,
                showWaLicense: showWaLicense,
                logoPath: logoPath,
                bankName: bankName,
                bankAccountName: bankAccountName,
                bankAccountNumber: bankAccountNumber,
                bankRoutingNumber: bankRoutingNumber,
                bankAccountType: bankAccountType,
                bankSwift: bankSwift,
                bankIban: bankIban,
                showBankDetails: showBankDetails,
                stripePaymentLink: stripePaymentLink,
                showStripeLink: showStripeLink,
                paymentInstructions: paymentInstructions,
                defaultCurrency: defaultCurrency,
                defaultHourlyRate: defaultHourlyRate,
                defaultTaxLabel: defaultTaxLabel,
                defaultTaxRate: defaultTaxRate,
                defaultPaymentTerms: defaultPaymentTerms,
                defaultPaymentTermsDays: defaultPaymentTermsDays,
                lateFeePercentage: lateFeePercentage,
                defaultTemplateId: defaultTemplateId,
                defaultEmailSubjectFormat: defaultEmailSubjectFormat,
                nextInvoiceNumber: nextInvoiceNumber,
                invoiceNumberPrefix: invoiceNumberPrefix,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> addressLine1 = const Value.absent(),
                Value<String?> addressLine2 = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> stateProvince = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<bool> showTaxId = const Value.absent(),
                Value<String?> waBusinessLicense = const Value.absent(),
                Value<bool> showWaLicense = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> bankAccountName = const Value.absent(),
                Value<String?> bankAccountNumber = const Value.absent(),
                Value<String?> bankRoutingNumber = const Value.absent(),
                Value<String> bankAccountType = const Value.absent(),
                Value<String?> bankSwift = const Value.absent(),
                Value<String?> bankIban = const Value.absent(),
                Value<bool> showBankDetails = const Value.absent(),
                Value<String?> stripePaymentLink = const Value.absent(),
                Value<bool> showStripeLink = const Value.absent(),
                Value<String?> paymentInstructions = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<double> defaultHourlyRate = const Value.absent(),
                Value<String> defaultTaxLabel = const Value.absent(),
                Value<double> defaultTaxRate = const Value.absent(),
                Value<String> defaultPaymentTerms = const Value.absent(),
                Value<int> defaultPaymentTermsDays = const Value.absent(),
                Value<double?> lateFeePercentage = const Value.absent(),
                Value<int?> defaultTemplateId = const Value.absent(),
                Value<String> defaultEmailSubjectFormat = const Value.absent(),
                Value<int> nextInvoiceNumber = const Value.absent(),
                Value<String> invoiceNumberPrefix = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                businessName: businessName,
                ownerName: ownerName,
                email: email,
                phone: phone,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                stateProvince: stateProvince,
                postalCode: postalCode,
                country: country,
                taxId: taxId,
                showTaxId: showTaxId,
                waBusinessLicense: waBusinessLicense,
                showWaLicense: showWaLicense,
                logoPath: logoPath,
                bankName: bankName,
                bankAccountName: bankAccountName,
                bankAccountNumber: bankAccountNumber,
                bankRoutingNumber: bankRoutingNumber,
                bankAccountType: bankAccountType,
                bankSwift: bankSwift,
                bankIban: bankIban,
                showBankDetails: showBankDetails,
                stripePaymentLink: stripePaymentLink,
                showStripeLink: showStripeLink,
                paymentInstructions: paymentInstructions,
                defaultCurrency: defaultCurrency,
                defaultHourlyRate: defaultHourlyRate,
                defaultTaxLabel: defaultTaxLabel,
                defaultTaxRate: defaultTaxRate,
                defaultPaymentTerms: defaultPaymentTerms,
                defaultPaymentTermsDays: defaultPaymentTermsDays,
                lateFeePercentage: lateFeePercentage,
                defaultTemplateId: defaultTemplateId,
                defaultEmailSubjectFormat: defaultEmailSubjectFormat,
                nextInvoiceNumber: nextInvoiceNumber,
                invoiceNumberPrefix: invoiceNumberPrefix,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({defaultTemplateId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (defaultTemplateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.defaultTemplateId,
                                referencedTable: $$UserProfilesTableReferences
                                    ._defaultTemplateIdTable(db),
                                referencedColumn: $$UserProfilesTableReferences
                                    ._defaultTemplateIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (UserProfile, $$UserProfilesTableReferences),
      UserProfile,
      PrefetchHooks Function({bool defaultTemplateId})
    >;
typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> contactName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> addressLine1,
      Value<String?> addressLine2,
      Value<String?> city,
      Value<String?> stateProvince,
      Value<String?> postalCode,
      Value<String?> country,
      Value<double?> hourlyRate,
      Value<String> currency,
      Value<double?> taxRate,
      Value<int?> defaultTemplateId,
      Value<String?> paymentTermsOverride,
      Value<int?> paymentTermsDaysOverride,
      Value<String?> notes,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> contactName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> addressLine1,
      Value<String?> addressLine2,
      Value<String?> city,
      Value<String?> stateProvince,
      Value<String?> postalCode,
      Value<String?> country,
      Value<double?> hourlyRate,
      Value<String> currency,
      Value<double?> taxRate,
      Value<int?> defaultTemplateId,
      Value<String?> paymentTermsOverride,
      Value<int?> paymentTermsDaysOverride,
      Value<String?> notes,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoiceTemplatesTable _defaultTemplateIdTable(_$AppDatabase db) =>
      db.invoiceTemplates.createAlias(
        $_aliasNameGenerator(
          db.clients.defaultTemplateId,
          db.invoiceTemplates.id,
        ),
      );

  $$InvoiceTemplatesTableProcessedTableManager? get defaultTemplateId {
    final $_column = $_itemColumn<int>('default_template_id');
    if ($_column == null) return null;
    final manager = $$InvoiceTemplatesTableTableManager(
      $_db,
      $_db.invoiceTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultTemplateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProjectsTable, List<Project>> _projectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.projects,
    aliasName: $_aliasNameGenerator(db.clients.id, db.projects.clientId),
  );

  $$ProjectsTableProcessedTableManager get projectsRefs {
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_projectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.clients.id, db.invoices.clientId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: $_aliasNameGenerator(db.clients.id, db.timeEntries.clientId),
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentTermsOverride => $composableBuilder(
    column: $table.paymentTermsOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentTermsDaysOverride => $composableBuilder(
    column: $table.paymentTermsDaysOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoiceTemplatesTableFilterComposer get defaultTemplateId {
    final $$InvoiceTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultTemplateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> projectsRefs(
    Expression<bool> Function($$ProjectsTableFilterComposer f) f,
  ) {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentTermsOverride => $composableBuilder(
    column: $table.paymentTermsOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentTermsDaysOverride => $composableBuilder(
    column: $table.paymentTermsDaysOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoiceTemplatesTableOrderingComposer get defaultTemplateId {
    final $$InvoiceTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultTemplateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get stateProvince => $composableBuilder(
    column: $table.stateProvince,
    builder: (column) => column,
  );

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<String> get paymentTermsOverride => $composableBuilder(
    column: $table.paymentTermsOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentTermsDaysOverride => $composableBuilder(
    column: $table.paymentTermsDaysOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$InvoiceTemplatesTableAnnotationComposer get defaultTemplateId {
    final $$InvoiceTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultTemplateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> projectsRefs<T extends Object>(
    Expression<T> Function($$ProjectsTableAnnotationComposer a) f,
  ) {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({
            bool defaultTemplateId,
            bool projectsRefs,
            bool invoicesRefs,
            bool timeEntriesRefs,
          })
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> addressLine1 = const Value.absent(),
                Value<String?> addressLine2 = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> stateProvince = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<double?> hourlyRate = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double?> taxRate = const Value.absent(),
                Value<int?> defaultTemplateId = const Value.absent(),
                Value<String?> paymentTermsOverride = const Value.absent(),
                Value<int?> paymentTermsDaysOverride = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                name: name,
                contactName: contactName,
                email: email,
                phone: phone,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                stateProvince: stateProvince,
                postalCode: postalCode,
                country: country,
                hourlyRate: hourlyRate,
                currency: currency,
                taxRate: taxRate,
                defaultTemplateId: defaultTemplateId,
                paymentTermsOverride: paymentTermsOverride,
                paymentTermsDaysOverride: paymentTermsDaysOverride,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> contactName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> addressLine1 = const Value.absent(),
                Value<String?> addressLine2 = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> stateProvince = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<double?> hourlyRate = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double?> taxRate = const Value.absent(),
                Value<int?> defaultTemplateId = const Value.absent(),
                Value<String?> paymentTermsOverride = const Value.absent(),
                Value<int?> paymentTermsDaysOverride = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                name: name,
                contactName: contactName,
                email: email,
                phone: phone,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                stateProvince: stateProvince,
                postalCode: postalCode,
                country: country,
                hourlyRate: hourlyRate,
                currency: currency,
                taxRate: taxRate,
                defaultTemplateId: defaultTemplateId,
                paymentTermsOverride: paymentTermsOverride,
                paymentTermsDaysOverride: paymentTermsDaysOverride,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                defaultTemplateId = false,
                projectsRefs = false,
                invoicesRefs = false,
                timeEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (projectsRefs) db.projects,
                    if (invoicesRefs) db.invoices,
                    if (timeEntriesRefs) db.timeEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (defaultTemplateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultTemplateId,
                                    referencedTable: $$ClientsTableReferences
                                        ._defaultTemplateIdTable(db),
                                    referencedColumn: $$ClientsTableReferences
                                        ._defaultTemplateIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (projectsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Project
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._projectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).projectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (timeEntriesRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          TimeEntry
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._timeEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).timeEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({
        bool defaultTemplateId,
        bool projectsRefs,
        bool invoicesRefs,
        bool timeEntriesRefs,
      })
    >;
typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      required int clientId,
      required String name,
      Value<String?> description,
      Value<double?> hourlyRateOverride,
      Value<int> color,
      Value<bool> isActive,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<int> clientId,
      Value<String> name,
      Value<String?> description,
      Value<double?> hourlyRateOverride,
      Value<int> color,
      Value<bool> isActive,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.projects.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: $_aliasNameGenerator(db.projects.id, db.timeEntries.projectId),
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoiceLineItemsTable, List<InvoiceLineItem>>
  _invoiceLineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceLineItems,
    aliasName: $_aliasNameGenerator(
      db.projects.id,
      db.invoiceLineItems.projectId,
    ),
  );

  $$InvoiceLineItemsTableProcessedTableManager get invoiceLineItemsRefs {
    final manager = $$InvoiceLineItemsTableTableManager(
      $_db,
      $_db.invoiceLineItems,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoiceLineItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRateOverride => $composableBuilder(
    column: $table.hourlyRateOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoiceLineItemsRefs(
    Expression<bool> Function($$InvoiceLineItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceLineItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLineItems,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLineItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRateOverride => $composableBuilder(
    column: $table.hourlyRateOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hourlyRateOverride => $composableBuilder(
    column: $table.hourlyRateOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoiceLineItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceLineItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceLineItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLineItems,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLineItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, $$ProjectsTableReferences),
          Project,
          PrefetchHooks Function({
            bool clientId,
            bool timeEntriesRefs,
            bool invoiceLineItemsRefs,
          })
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> hourlyRateOverride = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                clientId: clientId,
                name: name,
                description: description,
                hourlyRateOverride: hourlyRateOverride,
                color: color,
                isActive: isActive,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<double?> hourlyRateOverride = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                clientId: clientId,
                name: name,
                description: description,
                hourlyRateOverride: hourlyRateOverride,
                color: color,
                isActive: isActive,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                timeEntriesRefs = false,
                invoiceLineItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (timeEntriesRefs) db.timeEntries,
                    if (invoiceLineItemsRefs) db.invoiceLineItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$ProjectsTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$ProjectsTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (timeEntriesRefs)
                        await $_getPrefetchedData<
                          Project,
                          $ProjectsTable,
                          TimeEntry
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._timeEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).timeEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoiceLineItemsRefs)
                        await $_getPrefetchedData<
                          Project,
                          $ProjectsTable,
                          InvoiceLineItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._invoiceLineItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceLineItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, $$ProjectsTableReferences),
      Project,
      PrefetchHooks Function({
        bool clientId,
        bool timeEntriesRefs,
        bool invoiceLineItemsRefs,
      })
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required int clientId,
      required String invoiceNumber,
      Value<String> status,
      required DateTime issueDate,
      required DateTime dueDate,
      Value<DateTime?> periodStart,
      Value<DateTime?> periodEnd,
      Value<double> subtotal,
      Value<double> taxRate,
      Value<String> taxLabel,
      Value<double> taxAmount,
      Value<double> lateFeeAmount,
      Value<double> total,
      Value<double> amountPaid,
      Value<String> currency,
      Value<String?> notes,
      Value<int?> templateId,
      Value<String> templateType,
      Value<String?> pdfPath,
      Value<String?> paymentMethod,
      Value<DateTime?> paidDate,
      Value<DateTime?> sentDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<int> clientId,
      Value<String> invoiceNumber,
      Value<String> status,
      Value<DateTime> issueDate,
      Value<DateTime> dueDate,
      Value<DateTime?> periodStart,
      Value<DateTime?> periodEnd,
      Value<double> subtotal,
      Value<double> taxRate,
      Value<String> taxLabel,
      Value<double> taxAmount,
      Value<double> lateFeeAmount,
      Value<double> total,
      Value<double> amountPaid,
      Value<String> currency,
      Value<String?> notes,
      Value<int?> templateId,
      Value<String> templateType,
      Value<String?> pdfPath,
      Value<String?> paymentMethod,
      Value<DateTime?> paidDate,
      Value<DateTime?> sentDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.invoices.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoiceTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.invoiceTemplates.createAlias(
        $_aliasNameGenerator(db.invoices.templateId, db.invoiceTemplates.id),
      );

  $$InvoiceTemplatesTableProcessedTableManager? get templateId {
    final $_column = $_itemColumn<int>('template_id');
    if ($_column == null) return null;
    final manager = $$InvoiceTemplatesTableTableManager(
      $_db,
      $_db.invoiceTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.timeEntries.invoiceId),
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoiceLineItemsTable, List<InvoiceLineItem>>
  _invoiceLineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceLineItems,
    aliasName: $_aliasNameGenerator(
      db.invoices.id,
      db.invoiceLineItems.invoiceId,
    ),
  );

  $$InvoiceLineItemsTableProcessedTableManager get invoiceLineItemsRefs {
    final manager = $$InvoiceLineItemsTableTableManager(
      $_db,
      $_db.invoiceLineItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoiceLineItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxLabel => $composableBuilder(
    column: $table.taxLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lateFeeAmount => $composableBuilder(
    column: $table.lateFeeAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentDate => $composableBuilder(
    column: $table.sentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoiceTemplatesTableFilterComposer get templateId {
    final $$InvoiceTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoiceLineItemsRefs(
    Expression<bool> Function($$InvoiceLineItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceLineItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLineItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLineItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxLabel => $composableBuilder(
    column: $table.taxLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lateFeeAmount => $composableBuilder(
    column: $table.lateFeeAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentDate => $composableBuilder(
    column: $table.sentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoiceTemplatesTableOrderingComposer get templateId {
    final $$InvoiceTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get periodEnd =>
      $composableBuilder(column: $table.periodEnd, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<String> get taxLabel =>
      $composableBuilder(column: $table.taxLabel, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get lateFeeAmount => $composableBuilder(
    column: $table.lateFeeAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);

  GeneratedColumn<DateTime> get sentDate =>
      $composableBuilder(column: $table.sentDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoiceTemplatesTableAnnotationComposer get templateId {
    final $$InvoiceTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.invoiceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoiceLineItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceLineItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceLineItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLineItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLineItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool clientId,
            bool templateId,
            bool timeEntriesRefs,
            bool invoiceLineItemsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<DateTime?> periodStart = const Value.absent(),
                Value<DateTime?> periodEnd = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
                Value<String> taxLabel = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> lateFeeAmount = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> templateId = const Value.absent(),
                Value<String> templateType = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<DateTime?> sentDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                clientId: clientId,
                invoiceNumber: invoiceNumber,
                status: status,
                issueDate: issueDate,
                dueDate: dueDate,
                periodStart: periodStart,
                periodEnd: periodEnd,
                subtotal: subtotal,
                taxRate: taxRate,
                taxLabel: taxLabel,
                taxAmount: taxAmount,
                lateFeeAmount: lateFeeAmount,
                total: total,
                amountPaid: amountPaid,
                currency: currency,
                notes: notes,
                templateId: templateId,
                templateType: templateType,
                pdfPath: pdfPath,
                paymentMethod: paymentMethod,
                paidDate: paidDate,
                sentDate: sentDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                required String invoiceNumber,
                Value<String> status = const Value.absent(),
                required DateTime issueDate,
                required DateTime dueDate,
                Value<DateTime?> periodStart = const Value.absent(),
                Value<DateTime?> periodEnd = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
                Value<String> taxLabel = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> lateFeeAmount = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> templateId = const Value.absent(),
                Value<String> templateType = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<DateTime?> sentDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                clientId: clientId,
                invoiceNumber: invoiceNumber,
                status: status,
                issueDate: issueDate,
                dueDate: dueDate,
                periodStart: periodStart,
                periodEnd: periodEnd,
                subtotal: subtotal,
                taxRate: taxRate,
                taxLabel: taxLabel,
                taxAmount: taxAmount,
                lateFeeAmount: lateFeeAmount,
                total: total,
                amountPaid: amountPaid,
                currency: currency,
                notes: notes,
                templateId: templateId,
                templateType: templateType,
                pdfPath: pdfPath,
                paymentMethod: paymentMethod,
                paidDate: paidDate,
                sentDate: sentDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                templateId = false,
                timeEntriesRefs = false,
                invoiceLineItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (timeEntriesRefs) db.timeEntries,
                    if (invoiceLineItemsRefs) db.invoiceLineItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._templateIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._templateIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (timeEntriesRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          TimeEntry
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._timeEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).timeEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoiceLineItemsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoiceLineItem
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceLineItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceLineItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool clientId,
        bool templateId,
        bool timeEntriesRefs,
        bool invoiceLineItemsRefs,
      })
    >;
typedef $$TimeEntriesTableCreateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<int> id,
      required int clientId,
      Value<int?> projectId,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<int?> durationMinutes,
      Value<String?> description,
      Value<String?> issueReference,
      Value<String?> repository,
      Value<String?> tags,
      Value<bool> isManual,
      required double hourlyRateSnapshot,
      Value<bool> isInvoiced,
      Value<int?> invoiceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TimeEntriesTableUpdateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<int> id,
      Value<int> clientId,
      Value<int?> projectId,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<int?> durationMinutes,
      Value<String?> description,
      Value<String?> issueReference,
      Value<String?> repository,
      Value<String?> tags,
      Value<bool> isManual,
      Value<double> hourlyRateSnapshot,
      Value<bool> isInvoiced,
      Value<int?> invoiceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TimeEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntry> {
  $$TimeEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(db.timeEntries.clientId, db.clients.id),
      );

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
        $_aliasNameGenerator(db.timeEntries.projectId, db.projects.id),
      );

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<int>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.timeEntries.invoiceId, db.invoices.id),
      );

  $$InvoicesTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceLineItemsTable, List<InvoiceLineItem>>
  _invoiceLineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceLineItems,
    aliasName: $_aliasNameGenerator(
      db.timeEntries.id,
      db.invoiceLineItems.timeEntryId,
    ),
  );

  $$InvoiceLineItemsTableProcessedTableManager get invoiceLineItemsRefs {
    final manager = $$InvoiceLineItemsTableTableManager(
      $_db,
      $_db.invoiceLineItems,
    ).filter((f) => f.timeEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoiceLineItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TimeEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issueReference => $composableBuilder(
    column: $table.issueReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repository => $composableBuilder(
    column: $table.repository,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRateSnapshot => $composableBuilder(
    column: $table.hourlyRateSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInvoiced => $composableBuilder(
    column: $table.isInvoiced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceLineItemsRefs(
    Expression<bool> Function($$InvoiceLineItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceLineItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLineItems,
      getReferencedColumn: (t) => t.timeEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLineItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TimeEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issueReference => $composableBuilder(
    column: $table.issueReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repository => $composableBuilder(
    column: $table.repository,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRateSnapshot => $composableBuilder(
    column: $table.hourlyRateSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInvoiced => $composableBuilder(
    column: $table.isInvoiced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issueReference => $composableBuilder(
    column: $table.issueReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repository => $composableBuilder(
    column: $table.repository,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get isManual =>
      $composableBuilder(column: $table.isManual, builder: (column) => column);

  GeneratedColumn<double> get hourlyRateSnapshot => $composableBuilder(
    column: $table.hourlyRateSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isInvoiced => $composableBuilder(
    column: $table.isInvoiced,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceLineItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceLineItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceLineItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLineItems,
      getReferencedColumn: (t) => t.timeEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLineItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TimeEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeEntriesTable,
          TimeEntry,
          $$TimeEntriesTableFilterComposer,
          $$TimeEntriesTableOrderingComposer,
          $$TimeEntriesTableAnnotationComposer,
          $$TimeEntriesTableCreateCompanionBuilder,
          $$TimeEntriesTableUpdateCompanionBuilder,
          (TimeEntry, $$TimeEntriesTableReferences),
          TimeEntry,
          PrefetchHooks Function({
            bool clientId,
            bool projectId,
            bool invoiceId,
            bool invoiceLineItemsRefs,
          })
        > {
  $$TimeEntriesTableTableManager(_$AppDatabase db, $TimeEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<int?> projectId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> issueReference = const Value.absent(),
                Value<String?> repository = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                Value<double> hourlyRateSnapshot = const Value.absent(),
                Value<bool> isInvoiced = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TimeEntriesCompanion(
                id: id,
                clientId: clientId,
                projectId: projectId,
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                description: description,
                issueReference: issueReference,
                repository: repository,
                tags: tags,
                isManual: isManual,
                hourlyRateSnapshot: hourlyRateSnapshot,
                isInvoiced: isInvoiced,
                invoiceId: invoiceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                Value<int?> projectId = const Value.absent(),
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> issueReference = const Value.absent(),
                Value<String?> repository = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                required double hourlyRateSnapshot,
                Value<bool> isInvoiced = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TimeEntriesCompanion.insert(
                id: id,
                clientId: clientId,
                projectId: projectId,
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                description: description,
                issueReference: issueReference,
                repository: repository,
                tags: tags,
                isManual: isManual,
                hourlyRateSnapshot: hourlyRateSnapshot,
                isInvoiced: isInvoiced,
                invoiceId: invoiceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                projectId = false,
                invoiceId = false,
                invoiceLineItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceLineItemsRefs) db.invoiceLineItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable:
                                        $$TimeEntriesTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$TimeEntriesTableReferences
                                            ._clientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$TimeEntriesTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$TimeEntriesTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (invoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.invoiceId,
                                    referencedTable:
                                        $$TimeEntriesTableReferences
                                            ._invoiceIdTable(db),
                                    referencedColumn:
                                        $$TimeEntriesTableReferences
                                            ._invoiceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceLineItemsRefs)
                        await $_getPrefetchedData<
                          TimeEntry,
                          $TimeEntriesTable,
                          InvoiceLineItem
                        >(
                          currentTable: table,
                          referencedTable: $$TimeEntriesTableReferences
                              ._invoiceLineItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TimeEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceLineItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.timeEntryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TimeEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeEntriesTable,
      TimeEntry,
      $$TimeEntriesTableFilterComposer,
      $$TimeEntriesTableOrderingComposer,
      $$TimeEntriesTableAnnotationComposer,
      $$TimeEntriesTableCreateCompanionBuilder,
      $$TimeEntriesTableUpdateCompanionBuilder,
      (TimeEntry, $$TimeEntriesTableReferences),
      TimeEntry,
      PrefetchHooks Function({
        bool clientId,
        bool projectId,
        bool invoiceId,
        bool invoiceLineItemsRefs,
      })
    >;
typedef $$InvoiceLineItemsTableCreateCompanionBuilder =
    InvoiceLineItemsCompanion Function({
      Value<int> id,
      required int invoiceId,
      Value<int> sortOrder,
      required String description,
      required double quantity,
      required double unitPrice,
      required double total,
      Value<int?> timeEntryId,
      Value<int?> projectId,
      Value<DateTime> createdAt,
    });
typedef $$InvoiceLineItemsTableUpdateCompanionBuilder =
    InvoiceLineItemsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> sortOrder,
      Value<String> description,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> total,
      Value<int?> timeEntryId,
      Value<int?> projectId,
      Value<DateTime> createdAt,
    });

final class $$InvoiceLineItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $InvoiceLineItemsTable, InvoiceLineItem> {
  $$InvoiceLineItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.invoiceLineItems.invoiceId, db.invoices.id),
      );

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TimeEntriesTable _timeEntryIdTable(_$AppDatabase db) =>
      db.timeEntries.createAlias(
        $_aliasNameGenerator(
          db.invoiceLineItems.timeEntryId,
          db.timeEntries.id,
        ),
      );

  $$TimeEntriesTableProcessedTableManager? get timeEntryId {
    final $_column = $_itemColumn<int>('time_entry_id');
    if ($_column == null) return null;
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
        $_aliasNameGenerator(db.invoiceLineItems.projectId, db.projects.id),
      );

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<int>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceLineItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceLineItemsTable> {
  $$InvoiceLineItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimeEntriesTableFilterComposer get timeEntryId {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeEntryId,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLineItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceLineItemsTable> {
  $$InvoiceLineItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimeEntriesTableOrderingComposer get timeEntryId {
    final $$TimeEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeEntryId,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLineItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceLineItemsTable> {
  $$InvoiceLineItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TimeEntriesTableAnnotationComposer get timeEntryId {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeEntryId,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLineItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceLineItemsTable,
          InvoiceLineItem,
          $$InvoiceLineItemsTableFilterComposer,
          $$InvoiceLineItemsTableOrderingComposer,
          $$InvoiceLineItemsTableAnnotationComposer,
          $$InvoiceLineItemsTableCreateCompanionBuilder,
          $$InvoiceLineItemsTableUpdateCompanionBuilder,
          (InvoiceLineItem, $$InvoiceLineItemsTableReferences),
          InvoiceLineItem,
          PrefetchHooks Function({
            bool invoiceId,
            bool timeEntryId,
            bool projectId,
          })
        > {
  $$InvoiceLineItemsTableTableManager(
    _$AppDatabase db,
    $InvoiceLineItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceLineItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceLineItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceLineItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<int?> timeEntryId = const Value.absent(),
                Value<int?> projectId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoiceLineItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                sortOrder: sortOrder,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
                timeEntryId: timeEntryId,
                projectId: projectId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                Value<int> sortOrder = const Value.absent(),
                required String description,
                required double quantity,
                required double unitPrice,
                required double total,
                Value<int?> timeEntryId = const Value.absent(),
                Value<int?> projectId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoiceLineItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                sortOrder: sortOrder,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
                timeEntryId: timeEntryId,
                projectId: projectId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceLineItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({invoiceId = false, timeEntryId = false, projectId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (invoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.invoiceId,
                                    referencedTable:
                                        $$InvoiceLineItemsTableReferences
                                            ._invoiceIdTable(db),
                                    referencedColumn:
                                        $$InvoiceLineItemsTableReferences
                                            ._invoiceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (timeEntryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.timeEntryId,
                                    referencedTable:
                                        $$InvoiceLineItemsTableReferences
                                            ._timeEntryIdTable(db),
                                    referencedColumn:
                                        $$InvoiceLineItemsTableReferences
                                            ._timeEntryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$InvoiceLineItemsTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$InvoiceLineItemsTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InvoiceLineItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceLineItemsTable,
      InvoiceLineItem,
      $$InvoiceLineItemsTableFilterComposer,
      $$InvoiceLineItemsTableOrderingComposer,
      $$InvoiceLineItemsTableAnnotationComposer,
      $$InvoiceLineItemsTableCreateCompanionBuilder,
      $$InvoiceLineItemsTableUpdateCompanionBuilder,
      (InvoiceLineItem, $$InvoiceLineItemsTableReferences),
      InvoiceLineItem,
      PrefetchHooks Function({bool invoiceId, bool timeEntryId, bool projectId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$InvoiceTemplatesTableTableManager get invoiceTemplates =>
      $$InvoiceTemplatesTableTableManager(_db, _db.invoiceTemplates);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db, _db.timeEntries);
  $$InvoiceLineItemsTableTableManager get invoiceLineItems =>
      $$InvoiceLineItemsTableTableManager(_db, _db.invoiceLineItems);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
