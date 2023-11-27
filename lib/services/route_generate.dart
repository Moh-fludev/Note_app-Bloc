import 'package:flutter/material.dart';

import 'package:todo_bloc/UI/screens/tabs_screen.dart';

import '../UI/screens/recycle_bin_screen.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (context) => const RecycleBin(),
        );
      case TabsScreen.id:
        return MaterialPageRoute(
          builder: (context) => const TabsScreen(),
        );
    }
    return null;
  }
}
