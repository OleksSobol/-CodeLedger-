import 'dart:convert';
import 'package:flutter/material.dart';

/// All configurable fields for the time entry list tile.
enum TimeEntryField {
  timeRange,
  client,
  description,
  issue,
  repository,
  tags,
  status;

  String get label => switch (this) {
        timeRange => 'Time & Duration',
        client => 'Client',
        description => 'Description',
        issue => 'Issue',
        repository => 'Repository',
        tags => 'Tags',
        status => 'Status Badges',
      };

  IconData get icon => switch (this) {
        timeRange => Icons.schedule,
        client => Icons.business_outlined,
        description => Icons.notes_outlined,
        issue => Icons.tag,
        repository => Icons.folder_outlined,
        tags => Icons.label_outline,
        status => Icons.info_outline,
      };
}

/// Per-field visibility + ordering config.
class FieldConfig {
  final TimeEntryField field;
  final bool isVisible;
  final int order;

  const FieldConfig({
    required this.field,
    required this.isVisible,
    required this.order,
  });

  FieldConfig copyWith({bool? isVisible, int? order}) => FieldConfig(
        field: field,
        isVisible: isVisible ?? this.isVisible,
        order: order ?? this.order,
      );

  // ── Serialization ────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'field': field.name,
        'isVisible': isVisible,
        'order': order,
      };

  static FieldConfig fromJson(Map<String, dynamic> json) => FieldConfig(
        field: TimeEntryField.values.firstWhere(
          (f) => f.name == json['field'],
          orElse: () => TimeEntryField.description,
        ),
        isVisible: json['isVisible'] as bool,
        order: json['order'] as int,
      );

  // ── Defaults ─────────────────────────────────────────────────────

  static List<FieldConfig> defaults() => const [
        FieldConfig(field: TimeEntryField.timeRange, isVisible: true, order: 0),
        FieldConfig(field: TimeEntryField.client, isVisible: true, order: 1),
        FieldConfig(
            field: TimeEntryField.description, isVisible: true, order: 2),
        FieldConfig(field: TimeEntryField.issue, isVisible: true, order: 3),
        FieldConfig(
            field: TimeEntryField.repository, isVisible: false, order: 4),
        FieldConfig(field: TimeEntryField.tags, isVisible: true, order: 5),
        FieldConfig(field: TimeEntryField.status, isVisible: true, order: 6),
      ];

  // ── List serialization ───────────────────────────────────────────

  static String encode(List<FieldConfig> configs) =>
      jsonEncode(configs.map((c) => c.toJson()).toList());

  /// Decode from JSON, merging any new fields from defaults so the app
  /// never breaks when new fields are added in future updates.
  static List<FieldConfig> decode(String jsonStr) {
    try {
      final list = jsonDecode(jsonStr) as List;
      final loaded = list
          .map((e) => FieldConfig.fromJson(e as Map<String, dynamic>))
          .toList();
      // Append any default fields that weren't in the saved config.
      final loadedKeys = loaded.map((c) => c.field).toSet();
      final extras = defaults()
          .where((d) => !loadedKeys.contains(d.field))
          .map((d) => d.copyWith(order: loaded.length + d.order))
          .toList();
      return [...loaded, ...extras]
        ..sort((a, b) => a.order.compareTo(b.order));
    } catch (_) {
      return defaults();
    }
  }
}
