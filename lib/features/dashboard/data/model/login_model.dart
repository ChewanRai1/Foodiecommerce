class LoginModel {
  String email = '';
  String password = '';
  bool isPasswordVisible = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // You can add more complex email validation here if needed
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  bool validateAndSave() {
    // Replace form validation logic with your own
    if (validateEmail(email) == null && validatePassword(password) == null) {
      return true;
    }
    return false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  void saveEmail(String? value) {
    email = value ?? '';
  }

  void savePassword(String? value) {
    password = value ?? '';
  }
}
