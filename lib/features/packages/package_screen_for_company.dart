import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/enums.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'package_for_company_main_widget.dart';

class PackageScreenForCompany extends StatefulWidget {
  const PackageScreenForCompany({super.key});

  @override
  State<PackageScreenForCompany> createState() => _PackageScreenForCompanyState();
}

class _PackageScreenForCompanyState extends State<PackageScreenForCompany> {
  @override
  void initState() {
    super.initState();
    appBloc.getAllPackages(
      isForCorporate: userRoleName == Rules.Corporate.name,
      isForInsurance: userRoleName == Rules.Insurance.name,
      isForBroker: userRoleName == Rules.Broker.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: PackageForCompanyMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
