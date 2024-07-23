import 'package:flutter/cupertino.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: CupertinoActivityIndicator()),
          ],
        ),
      ],
    );
  }
}
