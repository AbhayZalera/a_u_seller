import 'package:a_u_seller/controller/home_controller.dart';
import 'package:a_u_seller/views/home_screen/home_screen.dart';
import 'package:a_u_seller/views/orders_screen/orders_screen.dart';
import 'package:a_u_seller/views/products_screen/products_screen.dart';
import 'package:a_u_seller/views/profile_screen/profile_screen.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/const.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    //Bottom Navigation
    var bottomNavbar = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            color: darkGrey,
            width: 25,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            color: darkGrey,
            width: 25,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            color: darkGrey,
            width: 25,
          ),
          label: settings)
    ];


    //For Show Screen
    var navScreens = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen(),


    ];


    return Scaffold(
      bottomNavigationBar: Obx(()=>
        BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
            currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldText(text: dashboard,color: fontGrey,size: 18.0),
      // ),
      body: Column(
        children: [Obx(()=> Expanded(child: navScreens.elementAt(controller.navIndex.value)))],
      ),
    );
  }
}
