import 'package:a_u_seller/views/widgets/text_style.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title){
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 18.0),
    actions: [
      Center(
          child: boldText(
              text:
              intl.DateFormat('EEE dd-MMM-yyyy').format(DateTime.now()),
              color: purpleColor)),
      10.widthBox,
    ],
  );
}