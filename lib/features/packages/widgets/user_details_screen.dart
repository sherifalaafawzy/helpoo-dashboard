import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/package_users_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/back_button_widget.dart';

import '../../../core/util/widgets/primary_button.dart';

import '../../client_fnol_and_inspection_req/widgets/my_rich_text.dart';

class UserDetailsScreen extends StatefulWidget {
  final Clients client;

  const UserDetailsScreen({
    super.key,
    required this.client,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 1000,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    space10Vertical(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButtonWidget(),
                        Text(
                          'User Details',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                      ],
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'User Id : ',
                      text2: '${widget.client.id ?? ''}',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Phone Number : ',
                      text2: widget.client.client?.user?.phoneNumber ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Name : ',
                      text2: widget.client.client?.user?.name ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Created At : ',
                      text2: widget.client.createdAt ?? '',
                    ),
                    space20Vertical(),
                    PrimaryButton(
                      text: 'Done',
                      onPressed: () {
                        appBloc.changeStackNav(
                          index: appBloc.currentSideMenuIndex,
                          isAdd: false,
                        );
                      },
                    ),
                    space20Vertical(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
