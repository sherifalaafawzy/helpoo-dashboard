import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/corporate_sr_table_main_widget.dart';

class CorporateServiceRequestPage extends StatefulWidget {
  const CorporateServiceRequestPage({
    super.key,
  });

  @override
  State<CorporateServiceRequestPage> createState() =>
      _CorporateServiceRequestPageState();
}

class _CorporateServiceRequestPageState
    extends State<CorporateServiceRequestPage> {
  @override
  void initState() {
    super.initState();
    appBloc.serviceRequestStep = 0;
    appBloc.clearFilters();
    appBloc.getCorporateServiceRequests(
      isFirstTime: true,
      pageNumber: 1
    );

    appBloc.getServiceRequestTypes();
    appBloc.getManufacturers();
    appBloc.getCarsModels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: CorporateSrTableMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
