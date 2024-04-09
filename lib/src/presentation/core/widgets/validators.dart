class FormValidators {
  static bool emailValidate(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  static bool emptyValidate(String value) {
    return value.isEmpty ? false : true;
  }

  static bool nameValidate(String value) {
    final regExp = RegExp(r'^[a-zA-Z ]+$');
    return regExp.hasMatch(value);
  }

  static bool phoneValidate(String value) {
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(value);
  }

  static bool ageValidate(String value) {
    final age = int.parse(value);
    return age < 18 ? false : true;
  }

  static bool userNameValidate(String value) {
    final regExp = RegExp(r'^[a-zA-Z0-9]+$');
    return regExp.hasMatch(value);
  }
}
