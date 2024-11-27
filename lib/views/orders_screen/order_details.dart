import 'package:a_u_seller/const/const.dart';
import 'package:a_u_seller/controller/orders_controller.dart';
import 'package:a_u_seller/views/widgets/our_button.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

import 'components/order_place.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetais extends StatefulWidget {
  final dynamic data;
  const OrderDetais({super.key, required this.data});

  @override
  State<OrderDetais> createState() => _OrderDetaisState();
}

class _OrderDetaisState extends State<OrderDetais> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.confirmed.value = widget.data['order_on_delivery'];
    controller.confirmed.value = widget.data['order_delivered'];
  }
  @override
  Widget build(BuildContext context) {


    return Obx(
        () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(color: green, onPress: () {
              controller.confirmed(true);
              controller.changeStatus(title: "order_confirmed", status: true, docID: widget.data.id);
            }, title: "Confirm Order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            //scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //Order Delivery Staus Section
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: boldText(
                            text: "Order Status", color: fontGrey, size: 16.0),
                      ),
                      SwitchListTile(
                        value: true,
                        activeColor: green,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        value: controller.confirmed.value,
                        activeColor: green,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        value: controller.onDelivery.value,
                        activeColor: green,
                        onChanged: (value) {
                          controller.onDelivery.value = value;
                          controller.changeStatus(title: "order_on_delivery", status: value, docID: widget.data.id);
                        },
                        title: boldText(text: "On Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        value: controller.delivered.value,
                        activeColor: green,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(title: "order_delivered", status: value, docID: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      )
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),

                //Order details Sections
                Column(
                  children: [
                    orderPlaceDetails(
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method",
                        context: context),
                    orderPlaceDetails(
                        //d1: DateTime.now(),
                        d1: intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                        title2: "Payment Method",
                        context: context),
                    orderPlaceDetails(
                        d1: "Unpaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status",
                        context: context),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: context.screenWidth / 2.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldText(
                                        text: "Shipping Address",
                                        color: purpleColor),
                                    "${widget.data['order_by_name']}".text.make(),
                                    "${widget.data['order_by_email']}".text.make(),
                                    "${widget.data['order_by_address']}".text.make(),
                                    "${widget.data['order_by_city']}".text.make(),
                                    "${widget.data['order_by_state']}".text.make(),
                                    "${widget.data['order_by_phone']}".text.make(),
                                    "${widget.data['order_by_PinCode']}".text.make(),
                                  ],
                                ),
                              )
                              //"Shipping Address".text.fontFamily(semibold).make(),
                            ],
                          ),
                          SizedBox(
                            width: context.screenWidth / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount", color: purpleColor),
                                boldText(text: '${widget.data['total_amount']}'.numCurrency, color: red, size: 16.0)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Orderd Prodcts", color: fontGrey, size: 16.0),
                10.heightBox,
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: "${controller.orders[index]['title']}",
                            title2: "${controller.orders[index]['tprice']}".numCurrency,
                            d1: "${controller.orders[index]['qty']} x ",
                            d2: "Refundable",
                            context: context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 2.0))
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
