import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import 'widgets/corporate_package_table.dart';
import 'package:hexcolor/hexcolor.dart';

class CorporatePackageMainWidget extends StatelessWidget {
  const CorporatePackageMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.isGetAllPackagesLoading ||
            appBloc.isGetPackageUsersLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }
        return const CorporatePackagesTable();
        // return SingleChildScrollView(
        //   child: Column(
        //     children: const [
        //       ,
        //     ],
        //   ),
        // );
      },
    );
  }
}
