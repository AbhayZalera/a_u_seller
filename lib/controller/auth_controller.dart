import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../const/const.dart';
import '../const/firebase_consts.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isloading = false.obs;

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
      VxToast.show(context, msg: "Logged out successfully.");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
