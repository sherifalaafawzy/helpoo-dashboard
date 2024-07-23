import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import 'widgets/clients_table.dart';
import 'package:hexcolor/hexcolor.dart';

class ClientsMainWidget extends StatelessWidget {
  const ClientsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.isGetAllUsersLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }
        return const ClientsTable();
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
