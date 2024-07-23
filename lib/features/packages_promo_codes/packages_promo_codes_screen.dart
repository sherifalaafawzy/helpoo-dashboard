import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'packages_promo_codes_main_widget.dart';

class PackagesPromoCodesScreen extends StatefulWidget {
  const PackagesPromoCodesScreen({super.key});

  @override
  State<PackagesPromoCodesScreen> createState() =>
      _PackagesPromoCodesScreenState();
}

class _PackagesPromoCodesScreenState extends State<PackagesPromoCodesScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.getAllPackagesPromoCodes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: PackagesPromoCodesMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
