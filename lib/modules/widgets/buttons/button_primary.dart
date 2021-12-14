import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruitshop/theme/dosis_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ButtonPrimary extends StatefulWidget {
  final double? fontSize;
  final String? buttonText;
  final Function()? callback;
  final bool? isLoading;

  const ButtonPrimary({
    this.fontSize,
    @required this.buttonText,
    @required this.callback,
    @required this.isLoading,
  });

  @override
  _ButtonPrimaryState createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  @override
  Widget build(BuildContext context) {

    return TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.pink.withOpacity(0.32); // Disabled color
            }
            return Colors.pink; // Regular color
          }),
        ),
        onPressed: widget.callback,
        child: Opacity(
            opacity: widget.callback == null ? 0.84 : 1,
            child: buttonTextChild()));
  }

  Widget buttonTextChild() {
    if (widget.isLoading!) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: Text(
          widget.buttonText!,
          maxLines: 1,
          style: DosisStyle.regular(context).merge(TextStyle(
              fontSize: widget.fontSize == null ? 16.sp : widget.fontSize)),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
