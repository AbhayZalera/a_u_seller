import 'package:a_u_seller/const/firebase_consts.dart';
import 'package:a_u_seller/views/products_screen/add_product.dart';
import 'package:a_u_seller/views/products_screen/product_details.dart';
import 'package:a_u_seller/views/widgets/appbar_widget.dart';
import 'package:a_u_seller/views/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../../controller/product_controller.dart';
import '../../services/store_services.dart';
import '../widgets/text_style.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    var controller = Get.put(ProductController());

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: purpleColor,
      //   onPressed: () async {
      //     await controller.getCategories();
      //     controller.populateCategoriesList();
      //     Get.to(() => const AddProduct());
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: white,
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          try {
            // Debug print to check if the button is pressed
            print("Floating Action Button pressed");

            // Fetch categories and populate the list
            await controller.getCategories();
            print("Categories fetched successfully");

            controller.populateCategoriesList();

            // Navigate to AddProduct screen
            Get.to(() => const AddProduct());
            print("Navigated to AddProduct screen");
          } catch (e) {
            // Catch and print any errors
            print("Error while navigating to AddProduct: $e");
          }
        },
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder<QuerySnapshot>(
        stream: StoreServices.getProduct(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circleColor: Colors.black);
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(
                                data: data[index],
                              ));
                        },
                        leading: Image.network(
                          "${data[index]['p_imgs'][0]}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(
                          text: "${data[index]['p_name']}",
                          color: fontGrey,
                        ),
                        subtitle: Row(
                          children: [
                            normalText(
                              text: "${data[index]['p_price']}".numCurrency,
                              color: darkGrey,
                            ),
                            const SizedBox(width: 10),
                            boldText(
                              text: data[index]['is_featured'] == true
                                  ? "Featured"
                                  : '',
                              color: green,
                            ),
                          ],
                        ),
                        trailing: VxPopupMenu(
                          menuBuilder: () => Column(
                            children: List.generate(
                              popupMenuTitles.length,
                              (i) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      popupMenuIcons[i],
                                      color: data[index]['featured_id'] ==
                                                  currentUser!.uid &&
                                              i == 0
                                          ? green
                                          : darkGrey,
                                    ),
                                    const SizedBox(width: 10),
                                    normalText(
                                      text: data[index]['featured_id'] ==
                                                  currentUser!.uid &&
                                              i == 0
                                          ? "Remove Fetured"
                                          : popupMenuTitles[i],
                                      color: darkGrey,
                                    ),
                                  ],
                                ).onTap(() {
                                  // switch (i) {
                                  //   case 0:
                                  //     if (data[index]['is_featured'] == true) {
                                  //       controller
                                  //           .removeFeatured(data[index].id);
                                  //       VxToast.show(context, msg: "Removed");
                                  //     } else {
                                  //       controller.addFeatured(data[index].id);
                                  //       VxToast.show(context, msg: "Added");
                                  //     }
                                  //     break;
                                  //   case 1:
                                  //     break;
                                  //   case 3:
                                  //     controller.removeProduct(data[index].id);
                                  //     VxToast.show(context, msg: "Removed");
                                  // }
                                  switch (i) {
                                    case 0:
                                      print("Feature toggle selected");
                                      if (data[index]['is_featured'] == true) {
                                        controller.removeFeatured(data[index].id);
                                        VxToast.show(context, msg: "Removed");
                                      } else {
                                        controller.addFeatured(data[index].id);
                                        VxToast.show(context, msg: "Added");
                                      }
                                      break;
                                    case 1:
                                      print("Edit selected");
                                      break;
                                    case 2:
                                      print("Remove selected, id: ${data[index].id}");
                                      controller.removeProduct(data[index].id);
                                      VxToast.show(context, msg: "Removed");
                                      break;
                                    default:
                                      VxToast.show(context, msg: "Unknown option selected");

                                  }

                                }),
                              ),
                            ),
                          ).box.white.width(200).rounded.make(),
                          clickType: VxClickType.singleClick,
                          child: const Icon(Icons.more_vert_rounded),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
