Duration? parseStepDuration(String stepText) {
  final text = stepText.toLowerCase();

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  final hourRegex = RegExp(r'(\d+)\s+hours?');
  final hourMatch = hourRegex.firstMatch(text);
  if (hourMatch != null) {
    hours = int.parse(hourMatch.group(1)!);
  }

  final minuteRegex = RegExp(r'(\d+)\s+(?:minutes?|mins?)');
  final minuteMatch = minuteRegex.firstMatch(text);
  if (minuteMatch != null) {
    minutes = int.parse(minuteMatch.group(1)!);
  }

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
