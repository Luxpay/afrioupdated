class Validators {
  static String? isValidEmail(String value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? validateTwoPassword(
      String newpassword, String confirmpassword) {
    if (newpassword.isEmpty && confirmpassword.isEmpty) {
      return "passeord cannot be empty";
    } else if (newpassword.length < 8 && confirmpassword.length < 8) {
      return 'Password most be more than 8 characters';
    } else if (newpassword != confirmpassword) {
      print(newpassword);
      print(confirmpassword);
      return "Password are not the same";
    } else {
      return null;
    }
  }

  static String? isValidPassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 8) {
      return 'Your password is too short at least 8 characters';
    } else if (!RegExp(r".*[0-9].*").hasMatch(value) ||
        !RegExp(r".*[A-Za-z].*").hasMatch(value)) {
      return "Your password must be 8 or more characters long & contain a mix of upper & lower case letters, numbers & symbols";
    } else {
      return null;
    }
  }

  // create a function that validates a phone number
  static String? isValidPhoneNumber(String value) {
    String patttern = r'(^[0-9]{10,11}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Phone number cannot be empty";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }
}
