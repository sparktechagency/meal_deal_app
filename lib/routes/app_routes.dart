import 'package:flutter/material.dart';
import 'package:meal_deal_app/feature/home/user/card/all_card_screen.dart';
import 'package:meal_deal_app/feature/home/user/card/card_screen.dart';
import 'package:meal_deal_app/feature/home/user/card/checkout_screen.dart';
import 'package:meal_deal_app/feature/home/user/card/oder_history_screen.dart';
import 'package:meal_deal_app/feature/home/user/chat/chat_inbox_screen.dart';
import 'package:meal_deal_app/feature/home/user/children/category_screen.dart';
import 'package:meal_deal_app/feature/home/user/children/cook_details_screen.dart';
import 'package:meal_deal_app/feature/home/user/children/cook_veiw_screen.dart';
import 'package:meal_deal_app/feature/home/user/children/product_details_screen.dart';
import 'package:meal_deal_app/feature/home/user/children/product_view_screen.dart';
import '../feature/auth/complete_profile/complete_profile_first_page.dart';
import '../feature/auth/forget/forget_screen.dart';
import '../feature/auth/login/log_in_screen.dart';
import '../feature/auth/otp/otp_screen.dart';
import '../feature/auth/reset_pass/reset_password_screen.dart';
import '../feature/auth/role/role_screen.dart';
import '../feature/auth/sign_up/sign_up_screen.dart';
import '../feature/bottom_nav_bar/cook_bottom_nav.dart';
import '../feature/bottom_nav_bar/user_bottom_nav.dart';

import '../feature/cook/registrations/agreement/agreement_screen.dart';
import '../feature/cook/registrations/agreement/confrim_screen.dart';
import '../feature/cook/registrations/completed/completed_screen.dart';
import '../feature/cook/registrations/completed/compliance_screen.dart';
import '../feature/cook/registrations/registration/business_number_screen.dart';
import '../feature/cook/registrations/registration/digital_form_screen.dart';
import '../feature/cook/registrations/registration/introduction_screen.dart';
import '../feature/cook/registrations/registration/official_registration_screen.dart';
import '../feature/cook/registrations/registration/registration_completed_screen.dart';
import '../feature/cook/registrations/registration/registration_submitted_screen.dart';
import '../feature/onboarding_screen.dart';
import '../feature/profile/edit_profile_screen.dart';
import '../feature/profile/setting/about_screen.dart';
import '../feature/profile/setting/change%20password/setting_change_password.dart';
import '../feature/profile/setting/privacy_policy_screen.dart';
import '../feature/profile/setting/setting_screen.dart';
import '../feature/profile/setting/terms_screen.dart';

import '../feature/splash_screen/splash_screen.dart';
abstract class AppRoutes {

  ///  ============= > initialRoute < ==============
  static const String initialRoute = splashScreen;



  ///  ============= > routes name < ==============
  static const String splashScreen = '/';
  static const String onboardingScreen = '/onboardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String otpScreen = '/otpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String uploadPhotoScreen = '/uploadPhotoScreen';
  static const String goalsScreen = '/goalsScreen';
  static const String bioScreen = '/bioScreen';
  static const String interestsScreen = '/interestsScreen';
  static const String enableLocationScreen = '/enableLocationScreen';
  static const String customBottomNavBar = '/customBottomNavBar';
  static const String notificationScreen = '/notificationScreen';
  static const String commentScreen = '/commentScreen';
  static const String settingScreen = '/settingScreen';
  static const String termsScreen = '/termsScreen';
  static const String policyScreen = '/policyScreen';
  static const String aboutScreen = '/aboutScreen';
  static const String changePassScreen = '/changePassScreen';
  static const String supportScreen = '/supportScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String walletScreen = '/walletScreen';
  static const String chatScreen = '/chatScreen';
  static const String loveScreen = '/loveScreen';
  static const String giftsScreen = '/giftsScreen';
  static const String postCreateScreen = '/postCreateScreen';
  static const String reportScreen = '/reportScreen';
  static const String reportDetailsScreen = '/reportDetailsScreen';
  static const String mediaScreen = '/mediaScreen';
  static const String profileDetailsScreen = '/profileDetailsScreen';
  static const String giftsMemberScreen = '/giftsMemberScreen';
  static const String bankInfoScreen = '/bankInfoScreen';
  static const String joinGuestScreen = '/joinGuestScreen';
  static const String galleryScreen = '/galleryScreen';
  static const String personalInfoScreen = '/personalInfoScreen';
  static const String inboxScreen = '/inboxScreen';
  static const String completeProfileFirstPage = '/completeProfileFirstPage';
  static const String roleScreen = '/roleScreen';
  static const String userBottomNavBar = '/userBottomNavBar';
  static const String categoryScreen = '/categoryScreen';
  static const String productViewScreen = '/productViewScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String cookViewScreen = '/cookViewScreen';
  static const String cookDetailsScreen = '/cookDetailsScreen';
  static const String cardScreen = '/cardScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String allCardScreen = '/allCardScreen';
  static const String oderHistoryScreen = '/oderHistoryScreen';
  static const String chatInboxScreen = '/chatInboxScreen';
  static const String officialRegistration = '/OfficialRegistration';
  static const String introductionScreen = '/IntroductionScreen';
  static const String digitalFormScreen = '/DigitalFormScreen';
  static const String registrationSubmittedScreen = '/RegistrationSubmittedScreen';
  static const String businessNumberScreen = '/BusinessNumberScreen';
  static const String registrationCompletedScreen = '/RegistrationCompletedScreen';
  static const String complianceScreen = '/ComplianceScreen';
  static const String completedScreen = '/CompletedScreen';

///cook role

  static const String agreementScreen = '/AgreementScreen';
  static const String confrimScreen = '/ConfrimScreen';

  ///  ============= > routes < ==============
  static final routes = <String, WidgetBuilder>{
    splashScreen : (context) => SplashScreen(),
    customBottomNavBar : (context) => CookBottomNavBar(),
    settingScreen : (context) => SettingScreen(),
    termsScreen : (context) => TermsScreen(),
    policyScreen : (context) => PrivacyPolicyScreen(),
    aboutScreen : (context) => AboutScreen(),
    changePassScreen : (context) => SettingChangePassword(),
    editProfileScreen : (context) => EditProfileScreen(),
    onboardingScreen : (context) => OnboardingScreen(),
    loginScreen : (context) => LoginScreen(),
    forgotScreen : (context) => ForgetScreen(),
    otpScreen : (context) => OtpScreen(),
    resetPasswordScreen : (context) => ResetPasswordScreen(),
    signUpScreen : (context) => SignUpScreen(),
    completeProfileFirstPage : (context) => CompleteProfileFirstPage(),
    roleScreen : (context) => RoleScreen(),
    userBottomNavBar : (context) => UserBottomNav(),
    categoryScreen : (context) => CategoryScreen(),
    productViewScreen : (context) => ProductViewScreen(),
    productDetailsScreen : (context) => ProductDetailsScreen(),
    cookViewScreen : (context) => CookViewScreen(),
    cookDetailsScreen : (context) => CookDetailsScreen(),
    cardScreen : (context) => CardScreen(),
    checkoutScreen : (context) => CheckoutScreen(),
    allCardScreen : (context) => AllCardScreen(),
    oderHistoryScreen : (context) => OrderHistoryScreen(),
    chatInboxScreen : (context) => ChatInboxScreen(),
    agreementScreen : (context) => AgreementScreen(),
    confrimScreen : (context) => ConfrimScreen(),
    officialRegistration : (context) => OfficialRegistration(),
    introductionScreen : (context) => IntroductionScreen(),
    digitalFormScreen : (context) => DigitalFormScreen(),
    registrationSubmittedScreen : (context) => RegistrationSubmittedScreen(),
    businessNumberScreen : (context) => BusinessNumberScreen(),
    registrationCompletedScreen : (context) => RegistrationCompletedScreen(),
    complianceScreen : (context) => ComplianceScreen(),
    completedScreen : (context) => CompletedScreen(),

  };
}
