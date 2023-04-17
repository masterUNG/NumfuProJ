import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:numfu/screen/cart.dart';
import 'package:numfu/utility/app_controller.dart';

class WidgetIconCart extends StatelessWidget {
  const WidgetIconCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          return badges.Badge(
            position: badges.BadgePosition.topEnd(end: -5, top: -4),
            badgeContent: Text(
              appController.sqliteModels.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
                onPressed: () {
                  Get.to(const Cart());
                },
                icon: const Icon(Icons.shopping_cart)),
          );
        });
  }
}
