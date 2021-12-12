import 'package:flutter/material.dart';
import 'package:fruitshop/modules/widgets/scaffolds/regular_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const RegularScaffold(
        title: "Loja de Frutas",
      ),
    );
  }
}