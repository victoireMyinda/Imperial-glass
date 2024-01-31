import 'package:get/get.dart';
import 'package:icecream_service/presentation/screens/home/home_screen.dart';
import 'package:icecream_service/presentation/screens/login/login_screen.dart';
import 'package:icecream_service/presentation/screens/signup/inscription.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step1.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step2.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step3.dart';
import 'package:icecream_service/presentation/screens/signup/signup.dart';
import 'package:icecream_service/refreshCheck.dart';
import 'package:icecream_service/routestack.dart';
import 'package:icecream_service/splashscreen.dart';
import 'package:icecream_service/version.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.cupertino),
         GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/routestack',
         page: () => const LoginScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/signupStep1',
        page: () => const SignupStep1(),
        transition: Transition.cupertino),
    GetPage(
        name: '/version',
        page: () => const VersionScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/refresh',
        page: () => const RefreshCheck(),
        transition: Transition.cupertino),
    GetPage(
        name: '/signupStep3',
        page: () => SignupStep3(backNavigation: false,),
        transition: Transition.cupertino),
    GetPage(
        name: '/signupStep2',
        page: () => const SignupStep2(),
        transition: Transition.cupertino),
    GetPage(
        name: '/signup',
        page: () => Signup(backNavigation: true,),
        transition: Transition.cupertino),

  
  ];
}
