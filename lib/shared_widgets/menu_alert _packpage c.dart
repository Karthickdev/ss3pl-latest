import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/screens/packapp/scanpages/multiscanpage/multi_item_view_model.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packappsinglescanpage/packappsingle_itemviewmodel.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/multiscanpage/multi_itemviewmodel.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/singlescanpage/singleitemviewmodel.dart';
import 'package:southshore3pl/shared_widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:southshore3pl/util/sizer.dart';

class AlertDialogBodypackapp extends ConsumerWidget {
  final String logoutMessage;
  const AlertDialogBodypackapp({Key? key, required this.logoutMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          logoutMessage,
          style: textStyles.kTextTitle,
        ),
        Sizer.vertical10(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Button(),
            Sizer.horizontal32(),
            CustomTextButton(
                textStyle: textStyles.kTextTitle,
                text: 'Cancel',
                onPress: () {
                  Navigator.pop(context);
                }),
          ],
        )
      ],
    );
  }
}

class AlertDialogBodypackappclient extends ConsumerWidget {
  final String logoutMessage;
  const AlertDialogBodypackappclient({Key? key, required this.logoutMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          logoutMessage,
          style: textStyles.kTextTitle,
        ),
        Sizer.vertical10(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Buttonclient(),
            Sizer.horizontal32(),
            CustomTextButton(
                textStyle: textStyles.kTextTitle,
                text: 'Cancel',
                onPress: () {
                  Navigator.pop(context);
                }),
          ],
        )
      ],
    );
  }
}

class AlertDialogHeaderpackapp extends StatelessWidget {
  const AlertDialogHeaderpackapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('ALERT!');
  }
}

class Button extends ConsumerWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final singleitemModel = watch(singleviewprovider);
    final multiitemModel = watch(multiviewprovider);
    final packsingleitemmodel = watch(packappsingleviewprovider);
    final packmultiitemModel = watch(packappmultiviewprovider);
    return CustomTextButton(
        textStyle: textStyles.kTextTitle,
        text: 'OK',
        onPress: () {
          singleitemModel.clearController();
          singleitemModel.clearDto();
          singleitemModel.clearError();
          packsingleitemmodel.clearEventLog();
          singleitemModel.clearEventLog();
          multiitemModel.clearEventLog();
          packmultiitemModel.clearEventLog();
          multiitemModel.clearController();
          multiitemModel.clearDto();
          multiitemModel.clearError();
          packsingleitemmodel.clearController();
          packsingleitemmodel.clearDto();
          packsingleitemmodel.clearError();
          packmultiitemModel.clearDto();
          packmultiitemModel.clearController();
          packsingleitemmodel.isavailable = false;
          packmultiitemModel.isavailable = false;
          Navigator.pop(context);
          Navigator.pop(context);
        });
  }
}

class AlertDialogHeaderpackappclient extends StatelessWidget {
  const AlertDialogHeaderpackappclient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('ALERT!');
  }
}

class Buttonclient extends ConsumerWidget {
  const Buttonclient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return CustomTextButton(
        textStyle: textStyles.kTextTitle,
        text: 'OK',
        onPress: () {
          Navigator.pop(context);
        });
  }
}
