/// Formats minutes into a human-readable string like "2h 30m".
String formatDuration(int totalMinutes) {
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  if (hours == 0) return '${minutes}m';
  if (minutes == 0) return '${hours}h';
  return '${hours}h ${minutes}m';
}

/// Formats minutes as decimal hours, e.g. 90 -> "1.50".
String formatDecimalHours(int totalMinutes) {
  return (totalMinutes / 60).toStringAsFixed(2);
}
