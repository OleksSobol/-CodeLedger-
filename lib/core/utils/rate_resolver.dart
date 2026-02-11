/// Resolves the effective hourly rate by cascading:
/// project override -> client rate -> profile default.
double resolveHourlyRate({
  double? projectRateOverride,
  double? clientRate,
  required double profileDefaultRate,
}) {
  if (projectRateOverride != null && projectRateOverride > 0) {
    return projectRateOverride;
  }
  if (clientRate != null && clientRate > 0) {
    return clientRate;
  }
  return profileDefaultRate;
}
