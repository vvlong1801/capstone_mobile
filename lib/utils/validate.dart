class Validator {
  static bool isEmailValid(String value) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(value);
  }
}
