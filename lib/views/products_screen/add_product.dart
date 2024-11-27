import 'package:a_u_seller/controller/product_controller.dart';
import 'package:a_u_seller/views/products_screen/component/product_dropdown.dart';
import 'package:a_u_seller/views/widgets/product_images.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../const/const.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: white,
            )),
        title: boldText(text: "Add Product", color: white),
        actions: [
          TextButton(
              onPressed: () async {
                await controller.uploadImages();
                await controller.uploadProduct(context);

              }, child: boldText(text: save, color: white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              // Product Name Field
              TextFormField(
                controller: controller.pnameController,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  hintText: "Product Name",
                  labelStyle: TextStyle(color: white),
                  hintStyle: TextStyle(color: Colors.white60),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                ),
                style: TextStyle(color: white),
              ),
              10.heightBox,

              // Product Description Field
              TextFormField(
                controller: controller.pdescController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Product Description",
                  labelStyle: TextStyle(color: white),
                  hintStyle: TextStyle(color: Colors.white60),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                ),
                maxLines: 4,
                style: TextStyle(color: white),
              ),
              10.heightBox,

              // Product Price Field
              TextFormField(
                controller: controller.ppriceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  hintText: "Product Price",
                  labelStyle: TextStyle(color: white),
                  hintStyle: TextStyle(color: Colors.white60),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                ),
                style: TextStyle(color: white),
                keyboardType: TextInputType.number,
              ),
              10.heightBox,

              // Product Quantity Field
              TextFormField(
                controller: controller.pquantityController,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  hintText: "Product Quantity",
                  labelStyle: TextStyle(color: white),
                  hintStyle: TextStyle(color: Colors.white60),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                ),
                style: TextStyle(color: white),
                keyboardType: TextInputType.number,
              ),
              const Divider(thickness: 0.2, color: white),
              5.heightBox,

              // Product Dropdown (Category Selection)
              productDropDown("Category", controller.categoryList,
                  controller.categoryvalue, controller),
              10.heightBox,

              // Another Product Dropdown (Subcategory)
              productDropDown("subcategory", controller.subcategoryList,
                  controller.subcategoryvalue, controller),
              10.heightBox,

              // Product Images Section
              boldText(text: "Choose Product Images"),
              7.heightBox,
               Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                    List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? SizedBox(
                                height: context.screenHeight / 7,
                                width: context.screenWidth / 4,
                                child:
                                    Image.file(controller.pImagesList[index]).onTap((){
                                      controller.pickImage(index, context);
                                    })
                        )
                            : SizedBox(
                                height: context.screenHeight / 6,
                                width: context.screenWidth / 4,
                                child: productImages(label: "${index + 1}")
                                    .onTap(() {
                                      setState(() {
                                        controller.pickImage(index, context);
                                      });

                                }),
                              ))),

              3.heightBox,
              normalText(text: "  • First image will be your display image"),
              const Divider(thickness: 0.2, color: white),
              5.heightBox,

              // Product Color Section
              // boldText(text: "Choose product color"),
              // 10.heightBox,
              // Obx(
              //   () => Wrap(
              //       spacing: 8,
              //       runSpacing: 8.0,
              //       children: List.generate(
              //         10,
              //         (index) => Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             VxBox(
              //                     // Random color circle
              //                     )
              //                 .color(Vx.randomPrimaryColor)
              //                 .roundedFull
              //                 .size(50, 50)
              //                 .make()
              //                 .onTap(() {
              //               controller.selectedColorIndex.value = index;
              //             }),
              //             controller.selectedColorIndex.value == index
              //                 ? const Icon(Icons.done, color: white)
              //                 : const SizedBox()
              //           ],
              //         ),
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
