import 'package:a_u_seller/views/widgets/text_style.dart';

import '../../const/const.dart';

Widget dashboardButton(context,{title,count,icon}){
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              boldText(text: title, size: 16.0),
              boldText(text: count, size: 20.0),
            ],
          )),
      Image.asset(icon, width: 40, color: white)
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width * 0.44, size.height * 0.12)
      .padding(const EdgeInsets.all(8.0))
      .make();
}