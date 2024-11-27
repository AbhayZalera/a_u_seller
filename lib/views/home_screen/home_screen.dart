import 'package:a_u_seller/const/firebase_consts.dart';
import 'package:a_u_seller/services/store_services.dart';
import 'package:a_u_seller/views/products_screen/product_details.dart';
import 'package:a_u_seller/views/widgets/dashboard_button.dart';
import 'package:a_u_seller/views/widgets/loading_indicator.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/const.dart';

import '../widgets/appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
          stream: StoreServices.getProduct(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: products, count: "${data.length}", icon: icProducts),
                            dashboardButton(context,
                                title: orders, count: '5.0', icon: icOrders),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: rating, count: "1", icon: icStar),
                            dashboardButton(context,
                                title: totlaSales, count: "5", icon: icOrders),
                          ],
                        ),
                        10.heightBox,
                        const Divider(),
                        10.heightBox,
                        boldText(text: popular, color: fontGrey, size: 16.0),
                        20.heightBox,
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              data.length,
                              (index) => data[index]['p_wishlist'].length == 0
                                  ? SizedBox()
                                  : ListTile(
                                      onTap: () {
                                        Get.to(() => ProductDetails(
                                              data: data[index],
                                            ));
                                      },
                                      leading: Image.network(
                                        data[index]['p_imgs'][0],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      title: boldText(
                                          text: "${data[index]['p_name']}",
                                          color: fontGrey),
                                      subtitle: normalText(
                                          text: "${data[index]['p_price']}"
                                              .numCurrency,
                                          color: darkGrey),
                                    )),
                        ),
                      ],
                    ),
                  ));
            }
          },
        ));
  }
}
