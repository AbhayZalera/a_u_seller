import 'package:a_u_seller/const/firebase_consts.dart';
import 'package:a_u_seller/services/store_services.dart';
import 'package:a_u_seller/views/messages_screen/chatScreen.dart';
import 'package:a_u_seller/views/widgets/loading_indicator.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Make sure to import Flutter material package
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../const/colors.dart';
import '../../const/strings.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: message, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
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
                      children: List.generate(data.length, (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t); // Fix date formatting

                        return ListTile(
                          onTap: () {
                            Get.to(() => const ChatScreen(
                                //friendId: data[index]['friendId'], // Pass friendId
                               // friendName: data[index]['sender_name'] // Pass sender_name
                            ));
                          },
                          leading: const CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(Icons.person, color: white),
                          ),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              color: fontGrey),
                          subtitle: normalText(
                              text: "${data[index]['last_msg']}", color: darkGrey),
                          trailing: normalText(text: time, color: darkGrey),
                        );
                      })),
                ),
              );
            }
          }),
    );
  }
}
