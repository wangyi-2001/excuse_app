import 'package:flutter/material.dart';

/// 页面跳转效果

// 淡入淡出
class CustomRouteJianBian extends PageRouteBuilder {
  final Widget widget;

  CustomRouteJianBian(this.widget)
      : super(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
                  parent: animation1, curve: Curves.fastOutSlowIn)),
              child: child,
            );
          },
        );
}

// 缩放
class CustomRouteZoom extends PageRouteBuilder {
  final Widget widget;

  CustomRouteZoom(this.widget)
      : super(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            return ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child);
          },
        );
}

// 旋转+缩放效果
class CustomRouteRotateZoom extends PageRouteBuilder {
  final Widget widget;

  CustomRouteRotateZoom(this.widget)
      : super(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            return RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animation1, curve: Curves.fastOutSlowIn)),
                child: ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1, curve: Curves.fastOutSlowIn)),
                  child: child,
                ));
          },
        );
}

// 从右向左滑动效果
class CustomRouteSlideRight extends PageRouteBuilder {
  final Widget widget;

  CustomRouteSlideRight(this.widget)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(CurvedAnimation(
                      parent: animation1, curve: Curves.fastOutSlowIn)),
              child: child,
            );
          },
        );
}

// 从左向右滑动效果
class CustomRouteSlideLeft extends PageRouteBuilder {
  final Widget widget;

  CustomRouteSlideLeft(this.widget)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(CurvedAnimation(
                      parent: animation1, curve: Curves.fastOutSlowIn)),
              child: child,
            );
          },
        );
}
