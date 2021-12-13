import 'package:flutter/material.dart';
import 'package:fruitshop/theme/dosis_style.dart';

class TextFieldSearch extends StatefulWidget {
  final TextEditingController? controller;
  final String? errorMessage;
  final String? placeHolder;
  final Function(String)? callback;

  const TextFieldSearch({
    this.controller,
    this.errorMessage,
    this.callback,
    this.placeHolder,
  });

  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Color(0xffD7D7D7))),
      padding: null,
      child: TextField(
        keyboardAppearance: darkModeOn ? Brightness.dark : Brightness.light,
        key: Key("campo_busca"),
        controller: widget.controller,
        autocorrect: false,
        onChanged: widget.callback!,
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          hintStyle: DosisStyle.regular(context)
              .merge(TextStyle(fontSize: 14, color: Color(0xffBDBDBD))),
          hintText: widget.placeHolder,
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
