import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/settings_main_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.getSettingTypes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: SettingsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
