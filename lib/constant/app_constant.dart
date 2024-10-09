class AppConstants {
  static final RegExp emailValidator = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp passwordValidator = RegExp(
    r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$", // At least one letter and one number
  );
}
