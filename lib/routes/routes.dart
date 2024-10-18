import 'package:get/get.dart';
import 'package:task/features/cart/cart_screen.dart';

import '../features/home/home_screen.dart';
import '../features/login_and_sign_up/login_screen.dart';
import '../features/login_and_sign_up/sign_up_screen.dart';

class RoutesPages {
  static final routes = [
    GetPage(
      name: RouteNames.initial,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RouteNames.signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: RouteNames.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: RouteNames.cart,
      page: () => const ShoeCartScreen(),
    ),
  ];
}

class RouteNames {
  static const initial = '/';
  static const home = '/home';
  static const signUp = '/signUp';
  static const cart = '/cart';
}
