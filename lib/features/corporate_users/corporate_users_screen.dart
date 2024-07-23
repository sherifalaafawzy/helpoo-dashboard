import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'corporate_users_main_widget.dart';

class CorporateUsersScreen extends StatefulWidget {
  const CorporateUsersScreen({super.key});

  @override
  State<CorporateUsersScreen> createState() => _CorporateUsersScreenState();
}

class _CorporateUsersScreenState extends State<CorporateUsersScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.getCorporateUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: CorporateUsersMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
