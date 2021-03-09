/// A class wrapping static validators.
/// Not a true service.
class ValidatorService {
  static String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else
      return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be at least 6 characters";
    } else if (value.length > 10) {
      return "Password should not be greater than 10 characters";
    } else
      return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '* Required';
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return '* Please enter a valid Email';
    }
    return null;
  }
}
