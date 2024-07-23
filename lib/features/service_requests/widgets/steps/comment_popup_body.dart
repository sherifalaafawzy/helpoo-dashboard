import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/extensions/build_context_extension.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';

class CommentPopupBody extends StatefulWidget {
  const CommentPopupBody({super.key});

  @override
  State<CommentPopupBody> createState() => _CommentPopupBodyState();
}

class _CommentPopupBodyState extends State<CommentPopupBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CommentOnRequestSuccessState) {
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          context.pop;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 800,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add comment on request',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                space10Vertical(),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryFormField(
                        validationError: 'Comment is required',
                        label: 'Comment*',
                        controller: appBloc.commentOnRequestController,
                      ),
                    ),
                  ],
                ),
                space10Vertical(),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          text: 'Confirm',
                          isLoading: appBloc.isCommentOnRequestLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              appBloc.commentOnRequest();
                            }
                          }),
                    ),
                    space10Horizontal(),
                    Expanded(
                      child: PrimaryButton(
                          text: 'Cancel',
                          backgroundColor: Colors.red,
                          onPressed: () {
                            appBloc.commentOnRequestController.clear();
                            context.pop;
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
