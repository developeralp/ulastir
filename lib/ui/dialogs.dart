import 'package:flutter/material.dart';
import 'package:ulastir/ui/designer.dart';
import 'package:ulastir/utils/localizer.dart';

class Dialogs {
  static Future<void> askDialog({
    required BuildContext context,
    required String title,
    required Function onYes,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title, style: TextStyle(color: Designer.textColor)),
            actions: <Widget>[
              TextButton(
                child: Text(
                  Localizer.i.text(
                    'dialog_no',
                  ),
                  style: TextStyle(color: Designer.textColorDefaultPrimary),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onYes();
                },
                child: Text(
                  Localizer.i.text('dialog_yes'),
                  style: TextStyle(color: Designer.textColorDefaultPrimary),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> showAlert(
      {required BuildContext context,
      required String title,
      required String text}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: Text(Localizer.i.text('ok')),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
