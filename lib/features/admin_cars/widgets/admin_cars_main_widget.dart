import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import 'admin_cars_table_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminCarsMainWidget extends StatelessWidget {
  const AdminCarsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.isGetAllAdminCarsLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return AdminCarsTableWidget(
          isLoading: appBloc.isGetAllAdminCarsLoadingForPagination,
        );
      },
    );
  }
}
