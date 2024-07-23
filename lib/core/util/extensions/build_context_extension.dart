import 'package:flutter/material.dart';

extension NavigationContext on BuildContext {
  get pop => Navigator.pop(this);

  void pushNamed(String routeName) => Navigator.pushNamed(this, routeName);

  void pushTo(Widget widget) => Navigator.push(this, MaterialPageRoute(builder: (context) => Scaffold(body: widget)));

  void pushNamedAndRemoveUntil(String routeName) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
}
