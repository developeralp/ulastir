import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            title: Text(title),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onYes();
                },
                child: const Text('EVET'),
              ),
              ElevatedButton(
                child: const Text('HAYIR'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  static Future<void> askTravelTimeEstimation(
      {required BuildContext context, required ValueChanged entered}) async {
    String input = '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Tahmini yolculuk süresi (dk) girin'),
            content: TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                input = value;
              },
              decoration: const InputDecoration(
                  hintText: 'Tahmini yolculuk süresi (örn. 5-60 dk)'),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('KAYDET'),
                onPressed: () async {
                  if (input.isEmpty) return;

                  int time = int.parse(input);

                  if (time > 300) {
                    return await showAlert(
                        context: context,
                        title: 'Uyarı',
                        text: 'Yolculuk süresi 300 dakikayı aşamaz');
                  }
                  Navigator.pop(context);

                  entered(time);
                },
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
              ElevatedButton(
                child: const Text('TAMAM'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
