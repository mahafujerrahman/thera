import 'package:get/get.dart';
import 'package:thera_track_app/views/screens/Auth/SignIn/sign_in_screen.dart';
import 'package:thera_track_app/views/screens/Auth/SignUp/sign_up_screen.dart';
import 'package:thera_track_app/views/screens/Auth/Verification/verify_screen.dart';
import 'package:thera_track_app/views/screens/Auth/forgotPassword/forgotPassword_screen.dart';
import 'package:thera_track_app/views/screens/Auth/resetPassword/resetPassword_screen.dart';
import 'package:thera_track_app/views/screens/Home/appointment/appointmentDetailsScreen.dart';
import 'package:thera_track_app/views/screens/Home/appointment/appointment_screen.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/chartArchive_screen.dart';
import 'package:thera_track_app/views/screens/Home/chartArchive/detailsChartArchive_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/animal/animal_list_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/animal/animal_contact_details_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/animal/edit_animal_contact_details_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/human/clients_contact_details_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/animal/animal_contact_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/contact_search_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/human/edit_contact_details_screen.dart';
import 'package:thera_track_app/views/screens/Home/contacts/human/human_client_contact_screen.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/animal_stepThree.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/appoinmentCalenderScreen.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/animal_details_StepSeven.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/humanStep/human_details_stepFive.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/humanStep/human_stepFour.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/humanStep/human_stepTwo.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/humanStep/human_stepthree.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/animal_stepFive.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/animal_stepFour.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/steps/createNew_chart_stepOne.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/animal_stepSix.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/steps/createNew_chart_stepTwo.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/equipment_screen.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/animalStep/animal_horseDetailsScreen.dart';
import 'package:thera_track_app/views/screens/Home/home_screen.dart';
import 'package:thera_track_app/views/screens/Home/inventory/inventory_screen.dart';
import 'package:thera_track_app/views/screens/Home/notification/notificationScreen.dart';
import 'package:thera_track_app/views/screens/Home/offline_file/offline_file_screen.dart';
import 'package:thera_track_app/views/screens/Splash/onboarding_screen.dart';
import 'package:thera_track_app/views/screens/Splash/splash_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/advanceSetting/advance_setting_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/subscription/subscription_now_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/yourDetails/edit_yourDetails_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/feedback/feedback_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/invoice/edit_invoiceSetup.dart';
import 'package:thera_track_app/views/screens/appDrawer/invoice/invoiceSetupScreen.dart';
import 'package:thera_track_app/views/screens/appDrawer/paid/paidDetails_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/subscription/subscription_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/treatment/treatment_screen.dart';
import 'package:thera_track_app/views/screens/appDrawer/unpaid/undPaidDetails_screen.dart';
import 'package:thera_track_app/views/screens/home/appointment/reschedule_calender.dart';
import 'package:thera_track_app/views/screens/home/travel/addCostScreen.dart';
import 'package:thera_track_app/views/screens/home/travel/costDetailsScreen.dart';
import 'package:thera_track_app/views/screens/home/travel/travel_screen.dart';
import '../views/screens/appDrawer/yourDetails/yourDetails_screen.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String onboardingScreen="/OnboardingScreen";
  static String signInScreen="/signInScreen";
  static String signUpScreen="/signUpScreen";
  static String forgotPasswordScreen="/ForgotPasswordScreen";
  static String verifyScreen="/verifyScreen";
  static String homeScreen="/homeScreen";

  static String yourDetailsScreen="/yourDetailsScreen";
  static String treatmentScreen="/treatmentScreen";
  static String editYourDetailsScreen="/editYourDetailsScreen";
  static String createNewChartStepOneScreen="/createNewChartStepOneScreen";
  static String paidDetailsScreen="/paidDetailsScreen";
  static String unPaidDetailsScreen="/unPaidDetailsScreen";
  static String feedbackScreen="/feedbackScreen";
//animal
  static String animalStepThreeScreen="/animalStepThreeScreen";

  static String createNewChartStepTwoScreen="/createNewChartStepTwoScreen";

  static String horseDetailsScreen="/horseDetailsScreen";
  static String chartArchiveScreen="/chartArchiveScreen";
  static String chartArchiveDetailsScreen="/chartArchiveDetailsScreen";
  static String appointmentScreen="/appointmentScreen";
  static String animalContactsScreen= "/animalContactsScreen";
  static String contactSearchScreen= "/contactSearchScreen";
  static String clientsContactDetailsScreen= "/clientsContactDetailsScreen";
  static String editContactDetailsScreen= "/human_editContactDetailsScreen";
  static String offLineFileScreen= "/offLineFileScreen";
  static String animalContactDetailsScreen= "/animalContactDetailsScreen";
  static String animalListScreen= "/animalListScreen";
  static String editAnimalContactDetailsScreen= "/editAnimalContactDetailsScreen";
  //Animal Step
  static String animalStepFourScreen = "/animalStepFourScreen";
  static String animalStepFiveScreen = "/animalStepFiveScreen";
  static String animalStepSixScreen = "/animalStepSixScreen";
  static String animalServiceDetailsScreen = "/animalServiceDetailsScreen";
  static String subscriptionNowScreen = "/subscription_now_screen";


  static String appoinmentCalenderScreen = "/appoinmentCalenderScreen";
  static String notificationScreen = "/notificationScreen";
  static String resetPassword = "/resetPassword";
  static String inventoryScreen = "/inventoryScreen";
  static String travelDetailsScreen = "/travelDetailsScreen";
  static String costAddScreen = "/costAddScreen";
  static String costDetailsScreen = "/costDetailsScreen";
  static String equipmentScreen = "/equipmentScreen";
  static String humanContactsScreen = "/humanContactsScreen";
  static String appointmentDetailsScreen = "/appointmentDetailsScreen";
  static String subscriptionScreen = "/subscriptionScreen";
  static String stripePaymentScreen = "/stripePaymentScreen";
  static String humanStepTwo = "/humanStepTwo";
  static String humanStepThree = "/humanStepThree";
  static String humanStepFour = "/humanStepFour";
  static String humanStepFive = "/HumanStepFive";
  static String invoiceSetupScreen = "/invoice_setupScreen";
  static String editInvoiceSetupScreen = "/edit_InvoiceSetupScreen";
  static String advanceSettingScreen = "/advanceSettingScreen";
  static String appoinmentRescheduleCalenderScreen = "/appoinmentRescheduleCalenderScreen";



 static List<GetPage> page=[

   //Auth part
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
    GetPage(name:onboardingScreen, page: ()=>const OnboardingScreen()),

    GetPage(name:signInScreen, page: ()=>const SignInScreen()),
    GetPage(name:signUpScreen, page: ()=>const SignUpScreen()),
    GetPage(name:forgotPasswordScreen, page: ()=>const ForgotPasswordScreen()),
    GetPage(name:verifyScreen, page: ()=>const VerifyScreen()),
    GetPage(name:resetPassword, page: ()=>const ResetPassword()),

   //Home
   GetPage(name:homeScreen, page: ()=> HomeScreen(),transition: Transition.noTransition),

   //App Drawer
   GetPage(name:editYourDetailsScreen, page: ()=> EditYourDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:yourDetailsScreen, page: ()=> YourDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:invoiceSetupScreen, page: ()=> InvoiceSetupScreen(),transition: Transition.noTransition),
   GetPage(name:editInvoiceSetupScreen, page: ()=> EditInvoiceSetupScreen(),transition: Transition.noTransition),
   GetPage(name:treatmentScreen, page: ()=> TreatmentScreen(),transition: Transition.noTransition),
   GetPage(name:paidDetailsScreen, page: ()=> PaidDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:unPaidDetailsScreen, page: ()=> UnPaidDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:feedbackScreen, page: ()=> FeedbackScreen(),transition: Transition.noTransition),
   GetPage(name:advanceSettingScreen, page: ()=> AdvanceSettingScreen(),transition: Transition.noTransition),

   //Create New Chart Step
   GetPage(name:createNewChartStepOneScreen, page: ()=> CreateNewChartStepOneScreen(),transition: Transition.noTransition),
   GetPage(name:createNewChartStepTwoScreen, page: ()=> CreateNewChartStepTwoScreen(),transition: Transition.noTransition),


   GetPage(name:horseDetailsScreen, page: ()=> HorseDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:appoinmentCalenderScreen, page: ()=> AppoinmentCalenderScreen(),transition: Transition.noTransition),
   GetPage(name:appoinmentRescheduleCalenderScreen, page: ()=> AppoinmentRescheduleCalenderScreen(),transition: Transition.noTransition),


   //ChartArchiveScreen
   GetPage(name:chartArchiveScreen, page: ()=> ChartArchiveScreen(),transition: Transition.noTransition),
   GetPage(name:chartArchiveDetailsScreen, page: ()=> ChartArchiveDetailsScreen(),transition: Transition.noTransition),

   //ChartArchiveScreen
   GetPage(name:appointmentScreen, page: ()=> AppointmentScreen(),transition: Transition.noTransition),

   //ContactsScreen
   GetPage(name:animalContactsScreen, page: ()=> AnimalContactsScreen(),transition: Transition.noTransition),
   GetPage(name:contactSearchScreen, page: ()=> ContactSearchScreen(),transition: Transition.noTransition),
   GetPage(name:clientsContactDetailsScreen, page: ()=> ClientsContactDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:editContactDetailsScreen, page: ()=> EditContactDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:animalContactDetailsScreen, page: ()=> AnimalContactDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:animalListScreen, page: ()=> AnimalListScreen(),transition: Transition.noTransition),
   GetPage(name:editAnimalContactDetailsScreen, page: ()=> EditAnimalContactDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:humanContactsScreen, page: ()=> HumanContactsScreen(),transition: Transition.noTransition),

   //OffLineFileScreen
   GetPage(name:offLineFileScreen, page: ()=> OffLineFileScreen(),transition: Transition.noTransition),

   //Inventory Screen
   GetPage(name:inventoryScreen, page: ()=> InventoryScreen(),transition: Transition.noTransition),
   // Wallet Details Screen
   GetPage(name:travelDetailsScreen, page: ()=> TravelDetailsScreen(),transition: Transition.noTransition),
   GetPage(name:costAddScreen, page: ()=> CostAddScreen(),transition: Transition.noTransition),
   GetPage(name:costDetailsScreen, page: ()=> CostDetailsScreen(),transition: Transition.noTransition),

   //Notification
   GetPage(name:notificationScreen, page: ()=> NotificationScreen(),transition: Transition.noTransition),


   // EquipmentScreen
   GetPage(name:equipmentScreen, page: ()=> EquipmentScreen(),transition: Transition.noTransition),
   GetPage(name:appointmentDetailsScreen, page: ()=> AppointmentDetailsScreen(),transition: Transition.noTransition),

   //Subscription Screen
   GetPage(name:subscriptionScreen, page: ()=> SubscriptionScreen(),transition: Transition.noTransition),
   GetPage(name:subscriptionNowScreen, page: ()=> SubscriptionNowScreen(),transition: Transition.noTransition),

   //human Step
   GetPage(name:humanStepTwo, page: ()=> HumanStepTwo(),transition: Transition.noTransition),
   GetPage(name:humanStepThree, page: ()=> HumanStepThree(),transition: Transition.noTransition),
   GetPage(name:humanStepFour, page: ()=> HumanStepFour(),transition: Transition.noTransition),
   GetPage(name:humanStepFive, page: ()=> HumanStepFive(),transition: Transition.noTransition),

   //animal step
   GetPage(name:animalStepThreeScreen, page: ()=> AnimalStepThreeScreen(),transition: Transition.noTransition),
   GetPage(name:animalStepFourScreen, page: ()=> AnimalStepFourScreen(),transition: Transition.noTransition),
   GetPage(name:animalStepFiveScreen, page: ()=> AnimalStepFiveScreen(),transition: Transition.noTransition),
   GetPage(name:animalStepSixScreen, page: ()=> AnimalStepSixScreen(),transition: Transition.noTransition),
   GetPage(name:animalServiceDetailsScreen, page: ()=> AnimalServiceDetailsScreen(),transition: Transition.noTransition),

 ];
}