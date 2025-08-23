String formatTime(int sec) {
  int min = sec ~/ 60;
  int seconds = sec % 60;

  String minStr = min.toString().padLeft(2, "0");
  String secStr = seconds.toString().padLeft(2, "0");

  return "$minStr:$secStr";
}
