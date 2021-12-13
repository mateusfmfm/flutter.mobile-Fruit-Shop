import 'package:flutter/material.dart';
import 'package:fruitshop/modules/widgets/buttons/button_primary.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:get/get.dart';

class WarningDialog extends StatefulWidget {
  const WarningDialog(
      {this.title, this.warningDescription, this.buttonText, this.buttonCallback, Key? key})
      : super(key: key);

  final String? title;
  final String? warningDescription;
  final String? buttonText;
  final Function()? buttonCallback;

  @override
  _WarningDialogState createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                widget.title!,
                textAlign: TextAlign.center,
                style: DosisStyle.bold(context).merge(
                  TextStyle(
                    fontSize: 18,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                widget.warningDescription!,
                textAlign: TextAlign.center,
                style: DosisStyle.regular(context).merge(
                  TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              height: 40,
              width: Get.width,
              margin: EdgeInsets.only(right: 4),
              child: ButtonPrimary(
                  fontSize: 16,
                  buttonText: widget.buttonText,
                  callback: widget.buttonCallback,
                  isLoading: false),
            ),
          ],
        ),
      ),
    );
  }
}
