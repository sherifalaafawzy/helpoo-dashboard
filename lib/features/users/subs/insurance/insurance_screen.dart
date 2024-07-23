import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import 'insurance_main_widget.dart';

class InsuranceUsersScreen extends StatefulWidget {
  const InsuranceUsersScreen({super.key});

  @override
  State<InsuranceUsersScreen> createState() => _InsuranceUsersScreenState();
}

class _InsuranceUsersScreenState extends State<InsuranceUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (appBloc.usersModel == null) {
      appBloc.getAllUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: InsuranceUsersMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
