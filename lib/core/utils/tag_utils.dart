// Shared helpers for parsing and serializing tag JSON strings.
// Tags are stored as JSON arrays: '["bugfix","frontend"]'

/// Parse a JSON tag string into a list of tag strings.
/// Returns an empty list if the input is null, empty, or malformed.
List<String> parseTags(String? tagsJson) {
  if (tagsJson == null || tagsJson.isEmpty) return [];
  try {
    return tagsJson
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();
  } catch (_) {
    return [];
  }
}

/// Convert comma-separated user input into a JSON array string.
/// Returns null if the input is blank.
/// e.g. 'bugfix, frontend' → '["bugfix","frontend"]'
String? serializeTags(String input) {
  final tags = input
      .split(',')
      .map((t) => t.trim())
      .where((t) => t.isNotEmpty)
      .toList();
  if (tags.isEmpty) return null;
  return '[${tags.map((t) => '"$t"').join(',')}]';
}

/// Convert a JSON tag string to a display string for text fields.
/// e.g. '["bugfix","frontend"]' → 'bugfix, frontend'
String tagsToDisplay(String? tagsJson) => parseTags(tagsJson).join(', ');
