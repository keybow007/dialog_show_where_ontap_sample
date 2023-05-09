import 'package:dialog_show_where_ontap_sample/dialog.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          final tappedPosition = details.globalPosition;
          print("tappedPosition: $tappedPosition");

          final adjustedTopLeft = _calcDialogTopLeft(tappedPosition);
          print("adjustedTopLeft: $adjustedTopLeft");

          showMyDialog(context, adjustedTopLeft);
        },
      ),
    );
  }

  Offset _calcDialogTopLeft(Offset tappedPosition) {
    /*
    * タップしたところがDialogの中心になるように調整
    * */
    final screenSize = MediaQuery.of(context).size;
    print("screenSize: $screenSize");

    var topLeftX = tappedPosition.dx - (myDialogSize.width / 2);
    if (topLeftX < 0) topLeftX = 0;
    if (topLeftX + myDialogSize.width > screenSize.width) {
      //単純に画面右端からDialogの横幅を引くだけだと
      topLeftX = screenSize.width - myDialogSize.width;
    }

    var topLeftY = tappedPosition.dy - (myDialogSize.height / 2);
    if (topLeftY < 0) topLeftY = 0;
    if (topLeftY + myDialogSize.height > screenSize.height) {
      topLeftY = screenSize.height - myDialogSize.height;
    }

    return Offset(topLeftX, topLeftY);
  }
}
