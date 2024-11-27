import 'package:a_u_seller/const/firebase_consts.dart';
import 'package:a_u_seller/controller/orders_controller.dart';
import 'package:a_u_seller/services/store_services.dart';
import 'package:a_u_seller/views/orders_screen/order_details.dart';
import 'package:a_u_seller/views/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/const.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());

    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      data.length,
                      (index) {
                        var time = data[index]['order_date'].toDate();
                        return
                        ListTile(
                          onTap: () {
                            Get.to(() => OrderDetais(data: data[index],));
                          },
                          tileColor: textfieldGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: boldText(text: "${data[index]['order_code']}", color: purpleColor),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month,
                                      color: fontGrey),
                                  10.widthBox,
                                  boldText(
                                      text: intl.DateFormat()
                                          .add_yMd()
                                          .format(time),
                                      color: fontGrey)
                                  //normalText(text: "1,500", color: darkGrey),
                                ],
                              ),
                              10.heightBox,
                              Row(
                                children: [
                                  const Icon(Icons.payment, color: fontGrey),
                                  10.widthBox,
                                  boldText(text: unpaid, color: red)
                                  //normalText(text: "1,500", color: darkGrey),
                                ],
                              ),
                            ],
                          ),
                          trailing: boldText(
                              text: "${data[index]['total_amount']}".numCurrency, color: purpleColor, size: 16.0),
                        ).box.margin(const EdgeInsets.only(bottom: 4.0)).make();
                      }
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
