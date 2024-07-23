import 'package:flutter/material.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/login_main_widget.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      scaffold: Scaffold(
        body: SafeArea(
          child: LoginMainWidget(),
        ),
      ),
    );
  }
}