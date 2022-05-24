import 'package:flutter/material.dart';

/// helper method to show `Not implemented` dialog upon user-triggered actions
void showNotImplemented() => notImplemented(AppNavigator.navigatorKey.currentContext!);

/// Class responsible of handling navigation between pages, this should not be used directly,
/// but trough "*Navigator" classes instead
class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<R?> push<R>(BuildContext context, Route<R> route, {bool useRoot = false}) async {
    return _navigator(context, useRoot: useRoot).push(route);
  }

  Future<R?> pushReplacement<R>(BuildContext context, Route<R> route, {bool useRoot = false, R? result}) async {
    return _navigator(context, useRoot: useRoot).pushReplacement(route, result: result);
  }

  void close(BuildContext context) => closeWithResult(context, null);

  void closeWithResult<T>(BuildContext context, T result) => _navigator(context).pop(result);

  void popUntilRoot(BuildContext context) => _navigator(context).popUntil((route) => route.isFirst);
}

Route<T> fadeInRoute<T>(Widget page, {int? durationMillis}) => PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: durationMillis ?? 250),
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: page,
      ),
    );

Route<T> materialRoute<T>(Widget page, {bool fullScreenDialog = false}) => MaterialPageRoute(
      builder: (context) => page,
      fullscreenDialog: fullScreenDialog,
    );

Route<T> slideBottomRoute<T>(Widget page, {int? durationMillis, bool fullScreenDialog = false}) => PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: durationMillis ?? 250),
      fullscreenDialog: fullScreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuint)),
        child: page,
      ),
    );

NavigatorState _navigator(BuildContext? context, {bool useRoot = false}) =>
    (useRoot || context == null) ? AppNavigator.navigatorKey.currentState! : Navigator.of(context);

void notImplemented(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: const Text('Not implemented'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        )
      ],
    ),
  );
}
