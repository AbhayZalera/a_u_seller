import 'package:a_u_seller/const/firebase_consts.dart';

class StoreServices {
  static getProfile(uid) {
    return fireStore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return fireStore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return fireStore
        .collection(ordersCollection)
        .where(vendorsCollection, arrayContains: uid)
        .snapshots();
  }

  static getProduct(uid) {
    return fireStore
        .collection(productCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  static getPopularProduct(uid) {
    return fireStore
        .collection(productCollection)
        .where('vendor_id', isEqualTo: uid)
        .orderBy('p_wishlist'.length);
  }
}
