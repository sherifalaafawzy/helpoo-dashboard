import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/enums.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'corporate_package_main_widget.dart';

class CorporatePackageScreen extends StatefulWidget {
  const CorporatePackageScreen({super.key});

  @override
  State<CorporatePackageScreen> createState() => _CorporatePackageScreenState();
}

class _CorporatePackageScreenState extends State<CorporatePackageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // debugPrint('userRoleName >>> $userRoleName');
    // appBloc.getAllPackages(
    //   isForCorporate: userRoleName == Rules.Corporate.name,
    //   isForInsurance: userRoleName == Rules.Insurance.name,
    //   isForBroker: userRoleName == Rules.Broker.name,
    // );
    appBloc.getPackageUsers(
      isForCompany: userRoleName == Rules.Corporate.name ||
          userRoleName == Rules.Insurance.name ||
          userRoleName == Rules.Broker.name,
      packageId: appBloc.selectedPackageId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        // if (state is GetAllPackagesSuccessState) {
        //   if (appBloc.allPackages.isNotEmpty) {
        //     appBloc.getPackageUsers(
        //       isForCompany: state.role.isCorporate || state.role.isInsurance || state.role.isBroker,
        //       packageId: appBloc.allPackages[0].id ?? 0,
        //     );
        //   }
        // }
      },
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: CorporatePackageMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
