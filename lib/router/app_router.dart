import 'package:southshore3pl/screens/printing/pack_printing_page.dart';
import 'package:southshore3pl/screens/printing/pick_Printer_page.dart';
import 'package:flutter/material.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/screens/login/loginscreen.dart';
import 'package:southshore3pl/screens/packapp/scanpages/multiscanpage/multi_item_scan_screen.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packappsinglescanpage/packappsingle_itemscanscreen.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packmenuscreen.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/multiscanpage/multi_itemscanscreen.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/pickmenuscreen.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/singlescanpage/singleitemscanscreen.dart';
import 'package:southshore3pl/screens/splash/splash_screen.dart';

import '../screens/main_menu_screen.dart';
import '../screens/tracking_scan_screen/tracking_scan_screen.dart';
import '../screens/pickapp/scanpages/singlescanpage/singleitemscanpage.dart';

class AppRouter {
  static Route? router(RouteSettings settings) {
    final dynamic args = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.pickmenuscreen:
        return MaterialPageRoute(builder: (_) => const PickmenuScreen());
      case Routes.singleitemscanscreen:
        return MaterialPageRoute(builder: (_) => const Singleitemscanscreen());
      case Routes.singleitemscanpage:
        return MaterialPageRoute(builder: (_) => SingleItemScanPage());
      case Routes.multiitemscanscreen:
        return MaterialPageRoute(builder: (_) => const Multiitemscanscreen());
      case Routes.mainmenuScreen:
        return MaterialPageRoute(builder: (_) => const MainmenuScreen());
      case Routes.packmenuScreen:
        return MaterialPageRoute(builder: (_) => const PackmenuScreen());
      case Routes.singleitempackscanscreen:
        return MaterialPageRoute(
            builder: (_) => const Singleitempackscanscreen());
      case Routes.packmultiitemscanscreen:
        return MaterialPageRoute(
            builder: (_) => const Packmultiitemscanscreen());
      case Routes.multiitemprinter:
        return MaterialPageRoute(builder: (_) => const Multiitemprinter());
      case Routes.singleitemprinter:
        return MaterialPageRoute(builder: (_) => const Singleitemprinter());
      case Routes.trackingnumberscan:
        return MaterialPageRoute(
            builder: (_) => Trackingnumberscanscreen(
                  data: args,
                ));
    }
    return null;
  }
}
