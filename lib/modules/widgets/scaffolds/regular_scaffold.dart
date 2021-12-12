import 'package:flutter/material.dart';
import 'package:fruitshop/theme/dosis_style.dart';

class RegularScaffold extends StatefulWidget {
  const RegularScaffold({Key? key, @required this.title}) : super(key: key);

  final String? title;

  @override
  _RegularScaffoldState createState() => _RegularScaffoldState();
}

class _RegularScaffoldState extends State<RegularScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title!,
          style: DosisStyle.regular(context)
              .merge(TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }
}
