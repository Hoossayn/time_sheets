import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../../../flavours/flavour_config.dart';
import '../../../../flavours/product_config.dart';


abstract class BaseStateWrapper<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  void onInit();

  void onDispose();

  void onPause();

  void onResume();

  void onHide();

  ProductConfig productConfig = FlavourConfig.instance.config;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onInit();
    super.initState();
  }

  Widget onBuild(
    BuildContext context,
    BoxConstraints constraints,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return onBuild(
        context,
        constraints,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    onDispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        onPause();
        break;
      case AppLifecycleState.detached:
        onDispose();
        break;
      case AppLifecycleState.hidden:
        onHide();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  void showLog(String message) {
    debugPrint(message);
  }

  void showLoading() {
    BotToast.showLoading();
  }

  void hideLoading() {
    BotToast.closeAllLoading();
  }

  void showToast(String message) {
    BotToast.showText(text: message);
  }

  void dismissKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
