import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/enums.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/service_requests_main_widget.dart';

class ServiceRequestsScreen extends StatefulWidget {
  final bool isFromCorporateAction;
  const ServiceRequestsScreen({super.key, this.isFromCorporateAction = false});

  @override
  State<ServiceRequestsScreen> createState() => _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends State<ServiceRequestsScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.serviceRequestStep = 0;
    appBloc.clearFilters();
    if (userRoleName == Rules.Corporate.name || widget.isFromCorporateAction) {
      appBloc.getCorporateServiceRequests(
        isFirstTime: true,
        pageNumber: 1
      );
    } else {
      appBloc.getAllServiceRequest(
        isFirstTime: true,
        pageNumber: 1
      );
    }

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
              child: ServiceRequestsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
