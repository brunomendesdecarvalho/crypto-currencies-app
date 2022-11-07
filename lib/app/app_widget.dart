import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'app_controller.dart';

class AppWidget extends StatefulWidget {
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    AppController appController = Modular.get();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: RxBuilder(builder: (context) {
        return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Mortgage Calculator',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: [Locale('pt', 'BR')],
            builder: BotToastInit(),
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate)
          ..navigatorObservers?.add(BotToastNavigatorObserver());
      }),
    );
  }
}
