import 'package:a_u_seller/views/widgets/text_style.dart';

import '../../../const/const.dart';

Widget chatBubble(){

  return Directionality(
    //textDirection: data['uid'] == currentUser!.uid ? TextDirection.ltr : TextDirection.rtl,
   textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          //color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
          color: purpleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            //child: "${data['msg']}".text.white.size(16).make(),
            child: normalText(text: "Uor Messages"),
          ),
          10.heightBox,
          normalText(text: "10.45 PM")
          //time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),

    ),
  );
}