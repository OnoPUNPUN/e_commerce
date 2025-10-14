import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_list_controller.dart';
import '../widgets/cart_item.dart';
import '../widgets/total_price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListController _cartListController = Get.find<CartListController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartListController.getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: GetBuilder(
        init: _cartListController,
        builder: (controller) {
          if (controller.inProgress) {
            return CenterCicularProgress();
          } else if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage ?? ''));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: controller.cartItemList.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      cartItemModel: controller.cartItemList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                ),
              ),
              TotalPriceAndCheckoutSection(),
            ],
          );
        },
      ),
    );
  }
}