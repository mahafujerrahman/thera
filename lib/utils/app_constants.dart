import '../models/language_model.dart';

class AppConstants{
  static String APP_NAME = "Home Health";
  static const String bearerToken = "BearerToken";

  static const String phoneNumber = "PhoneNumber";
  static String isLogged = "IsLogged";


  static String userId="userId";
  // share preference Key
  static String THEME ="theme";
  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );
  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel( languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel( languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];


  static String fullName = "FullName";
  static String email = "Email";
  static String address = "Address";
  static String role = "Role";
  static String selectedOption = "selectedOption";
  static String fcmToken = "fcmToken";




  static String productId="productId";
  static String userLat="userLat";
  static String userLag="userLag";

}
enum Status { loading, completed, error, internetError }