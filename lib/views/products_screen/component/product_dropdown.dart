import 'package:a_u_seller/const/const.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import '../../../controller/product_controller.dart';

Widget productDropDown(
    String hint,
    List<String> itemsList,
    RxString dropvalue,
    ProductController controller,
    ) {
  return Obx(
        () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: hint, color: fontGrey),
        value: dropvalue.value.isEmpty ? null : dropvalue.value,
        isExpanded: true,
        items: itemsList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: normalText(text: e, color: fontGrey),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            dropvalue.value = newValue;
            if (hint == "Category") {
              // Reset subcategory value and update based on selected category
              controller.subcategoryvalue.value = '';
              controller.populateSubcategories(newValue);
            }
          }
        },
      ),
    )
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}




// Widget productDropDown(hint, List<String> List, dropvalue) {
//   return DropdownButtonHideUnderline(
//           child: DropdownButton(
//     hint: normalText(text: hint, color: fontGrey),
//     value: dropvalue.value == '' ? null : dropvalue.value,
//     isExpanded: true,
//     items: List.map((e) {
//       return DropdownMenuItem(value: e, child: e.toString().text.make());
//     }),
//     onChanged: (value) {},
//   ))
//       .box
//       .white
//       .roundedSM
//       .padding(const EdgeInsets.symmetric(horizontal: 4))
//       .make();
// // }
//
// import 'package:a_u_seller/const/const.dart';
// import 'package:a_u_seller/controller/product_controller.dart';
// import 'package:a_u_seller/views/widgets/text_style.dart';
//
// Widget productDropDown(String hint, List<String> itemsList, dropvalue, ProductController controller) {
//   return DropdownButtonHideUnderline(
//     child: DropdownButton(
//       hint: normalText(text: hint, color: fontGrey),
//       value: dropvalue.value == '' ? null : dropvalue.value,
//       isExpanded: true,
//       items: itemsList.map((e) {
//         return DropdownMenuItem(
//             value: e, child: normalText(text: e, color: fontGrey));
//       }).toList(),
//       onChanged: (newValue) {
//         if (hint == "Category") {
//           controller.subcategoryvalue.value = '';
//           controller.populateCategoriesList(newValue);
//         }
//         dropvalue.value = newValue.toString();
//       },
//     ),
//   )
//       .box
//       .white
//       .roundedSM
//       .padding(const EdgeInsets.symmetric(horizontal: 4))
//       .make();
// }
