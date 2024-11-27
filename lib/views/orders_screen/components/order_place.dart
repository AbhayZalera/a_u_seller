import 'package:a_u_seller/views/widgets/text_style.dart';

import '../../../const/const.dart';

Widget orderPlaceDetails(
    {title1, title2, d1, d2, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.screenWidth / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title1", color: purpleColor),
              boldText(text: "$d1", color: red),
              // "$title1".text.fontFamily(semibold).make(),
              // "$d1".text.color(redColor).fontFamily(semibold).make(),
            ],
          ),
        ),
        SizedBox(
          width: context.screenWidth / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2", color: purpleColor),
              boldText(text: "$d2", color: fontGrey),
              // "$title2".text.fontFamily(semibold).make(),
              // "$d2".text.color(redColor).fontFamily(semibold).make(),
            ],
          ),
        )
      ],
    ),
  );
}
