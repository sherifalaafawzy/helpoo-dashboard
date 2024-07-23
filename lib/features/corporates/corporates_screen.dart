import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'corporates_main_widget.dart';

class CorporatesScreen extends StatefulWidget {
  const CorporatesScreen({super.key});

  @override
  State<CorporatesScreen> createState() => _CorporatesScreenState();
}

class _CorporatesScreenState extends State<CorporatesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.getAllCorporates();
    appBloc.getServiceRequestTypes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: CorporatesMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
