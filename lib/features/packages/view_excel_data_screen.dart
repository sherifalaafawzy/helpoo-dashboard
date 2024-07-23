import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/view_excel_data_table.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewExcelDataScreen extends StatefulWidget {
  const ViewExcelDataScreen({super.key});

  @override
  State<ViewExcelDataScreen> createState() => _ViewExcelDataScreenState();
}

class _ViewExcelDataScreenState extends State<ViewExcelDataScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: ViewExcelDataMainWidget(),
            ),
          ),
        );
      },
    );
  }
}

class ViewExcelDataMainWidget extends StatelessWidget {
  const ViewExcelDataMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.isGetAllPackagesLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }
        return const ViewExcelDataTable();
      },
    );
  }
}