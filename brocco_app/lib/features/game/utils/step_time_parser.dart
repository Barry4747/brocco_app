/// Parses a step description (in English) and extracts a [Duration]
/// if the text contains a time expression like "15 minutes", "2 hours",
/// "30 seconds", "1 hour and 30 minutes", etc.
///
/// Returns `null` if no recognisable time expression is found.
Duration? parseStepDuration(String stepText) {
  final text = stepText.toLowerCase();

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  // Match patterns like "2 hours", "1 hour"
  final hourRegex = RegExp(r'(\d+)\s+hours?');
  final hourMatch = hourRegex.firstMatch(text);
  if (hourMatch != null) {
    hours = int.parse(hourMatch.group(1)!);
  }

  // Match patterns like "15 minutes", "30 mins"
  final minuteRegex = RegExp(r'(\d+)\s+(?:minutes?|mins?)');
  final minuteMatch = minuteRegex.firstMatch(text);
  if (minuteMatch != null) {
    minutes = int.parse(minuteMatch.group(1)!);
  }

  // Match patterns like "30 seconds", "45 secs"
  final secondRegex = RegExp(r'(\d+)\s+(?:seconds?|secs?)');
  final secondMatch = secondRegex.firstMatch(text);
  if (secondMatch != null) {
    seconds = int.parse(secondMatch.group(1)!);
  }

  if (hours == 0 && minutes == 0 && seconds == 0) {
    return null;
  }

  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}
