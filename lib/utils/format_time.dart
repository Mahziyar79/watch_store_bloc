String formatTime(int sec) {
  String resultFormat;
  final duration = Duration(seconds: sec);

  String h = duration.inHours.toString().padLeft(2, "0");
  String m = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
  String s = duration.inSeconds.remainder(60).toString().padLeft(2, "0");

  if (sec > 3600) {
    resultFormat = "$h:$m:$s";
  } else {
    resultFormat = "$m:$s";
  }

  return resultFormat;
}