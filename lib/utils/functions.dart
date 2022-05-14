String getTimeForCountDown(int time) {
  int minute = (time / 60).floor();
  int seconds = time % 60;
  String one = minute < 10 ? '0$minute' : '$minute';
  String two = seconds < 10 ? '0$seconds' : '$seconds';
  return "$one:$two";
}

String obscureEmail(String email) {
  try {
    String obscuredEmail = "";
    int indexOfAt = email.indexOf("@");
    int length = (indexOfAt - 2) - 1;
    String obscuredCharacters = List.generate(length, (index) => "*").join("");
    obscuredEmail =
        email[0] + obscuredCharacters + email.substring(indexOfAt - 2);
    return obscuredEmail;
  } catch (e) {
    return email;
  }
}
