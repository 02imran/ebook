class Validator {
  static String validateName({ String? name}) {
    if (name == null) {
      return '';
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return '';
  }

  static String validateEmail({ String ?email}) {
    if (email == null) {
      return '';
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return'';
  }

  static String validatePassword({ String ?password}) {
    if (password == null) {
      return '';
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return '';
  }
}