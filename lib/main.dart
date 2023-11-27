import 'package:flutter/material.dart';
import 'package:todo_bloc/UI/screens/tabs_screen.dart';
import 'package:todo_bloc/bloc/switch_bloc/switch_bloc.dart';
import 'package:todo_bloc/services/route_generate.dart';
import 'package:todo_bloc/services/them.dart';

import 'bloc/bloc_extentions.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(appRoute: AppRoute()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.appRoute, super.key});
  final AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.switchValue
                ? AppThemes.appThemData[AppTheme.darkTheme]
                : AppThemes.appThemData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRoute.onGenerateRoute,
          );
        },
      ),
    );
  }
}
