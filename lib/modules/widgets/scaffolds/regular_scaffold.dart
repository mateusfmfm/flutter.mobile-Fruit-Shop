import 'package:flutter/material.dart';
import 'package:fruitshop/theme/dosis_style.dart';

class RegularScaffold extends StatefulWidget {
  const RegularScaffold(
      {Key? key,
      @required this.title,
      @required this.showBackButton,
      this.drawerEnabled = false,
      this.widget})
      : super(key: key);

  final String? title;
  final bool? showBackButton;
  final bool? drawerEnabled;
  final Widget? widget;

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
              .merge(TextStyle(fontSize: 18, color: Colors.white)),
        ),
        actions: [
          Icon(Icons.shopping_cart, color: Colors.white),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: Padding(padding: EdgeInsets.all(25), child: widget.widget,
      ),
    );
  }
}
