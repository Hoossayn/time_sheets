import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/blocs/timesheet/time_sheets_bloc.dart';
import 'app/blocs/timesheet/time_sheets_state.dart';
import 'app/core/core.dart';
import 'flavours/flavour_config.dart';
import 'flavours/product_config.dart';
import 'l10n/app_localizations.dart';

class BaseApp extends StatelessWidget {
  BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TimesheetBloc()..add(TimerSheetEventLoad())),
       // BlocProvider(create: (context) => NavState()),
        //BlocProvider(create: (context) => ThemeCubit()),
      ],
      child:  _MaterialApp(),
    );
  }

}

class _MaterialApp extends StatelessWidget {
   _MaterialApp();

  final botToastBuilder = BotToastInit();
  final ProductConfig _productConfig = FlavourConfig.instance.config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Time sheets',
      theme: _productConfig.theme.theme,
      routerConfig: AppRoutes.router,
      locale: const Locale('en', ''),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
    );
  }
}
