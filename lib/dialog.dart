import 'package:flutter/material.dart';

const myDialogSize = Size(200, 200);

void showMyDialog(BuildContext context, Offset topLeft) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      //Dialogの背景を透明にしないとSizedBoxから外れたDialogの余白部分が白くなってしまう
      backgroundColor: Colors.transparent,
      alignment: Alignment.topLeft,
      insetPadding: EdgeInsets.only(left: topLeft.dx, top: topLeft.dy),
      /*
      * SizedBoxで大きさを指定しているはずなのになぜか横幅がstretchしてしまう問題発生
      * => SizedBoxをAlignかCenterでくるむとうまくいくらしいが今回の場合だとDialogそのものもずれてしまう
      *   https://github.com/flutter/flutter/issues/68840#issuecomment-715222130
      * => SizedBoxをColumnでくるんでやるとうまくいくみたい
      *   https://stackoverflow.com/a/57364704/7300575
      *
      * */
      child: Column(
        //Columnの縦幅をSizedBox分だけにしたいので（MainAxisSize.minに）
        mainAxisSize: MainAxisSize.min,
        //ColumnをDialogの左端に寄せることで画面の左端にSizedBoxを表示させることができる
        // （デフォルトだと真ん中になるので画面左端にSizedBoxが出せない）
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: myDialogSize.width,
            height: myDialogSize.height,
            child: Stack(
              children: [
                Container(
                  color: Colors.blueAccent,
                ),
                 Positioned(
                   left: 8.0,
                   right: 8.0,
                   bottom: 8.0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("閉じる"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
