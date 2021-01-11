import 'package:food_cafe/binding/notification_binding.dart';
import 'package:food_cafe/ui/page/all_find_page.dart';
import 'package:food_cafe/ui/page/change_password_page.dart';
import 'package:food_cafe/ui/page/new_order_page.dart';
import 'package:food_cafe/ui/page/notification_page.dart';
import 'package:food_cafe/ui/page/profile_edit_page.dart';
import 'package:food_cafe/ui/page/sign_up_page.dart';
import 'package:food_cafe/ui/page/turn_of_ordering.dart';
import 'package:get/route_manager.dart';
import 'binding/binding.dart';
import 'resource/routes.dart';
import 'ui/page/home_page.dart';
import 'ui/page/login_page.dart';
import 'ui/page/past_order_page.dart';
import 'ui/page/splash_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: firstLaunchRoute,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(name: loginRoute, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: signUpRoute, page: () => SignUpPage(), binding: SignUpBinding()),
    GetPage(name: changePasswordRoute, page: () => ChangePasswordPage(), binding: ChangePasswordBinding()),
    GetPage(
        name: profileEditRoute,
        page: () => ProfileEditPage(),
        binding: ProfileEditBinding()),
    GetPage(name: notificationRoute, page: () => NotificationPage(), binding: NotificationBinding()),
    GetPage(name: homeRoute, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: pastOrderRoute,
        page: () => PastOrderPage(),
        binding: PastOrderBinding()),
    GetPage(
        name: newOrderRoute,
        page: () => NewOrderPage(),
        binding: NewOrderBinding()),
    GetPage(
        name: allFindRoute,
        page: () => AllFindPage(),
        binding: AllFindBinding()),
    GetPage(
        name: turnOfOrderingRoute,
        page: () => TurnOfOrderingPage(),
        binding: TurnOfOrderingBinding())
  ];
}
