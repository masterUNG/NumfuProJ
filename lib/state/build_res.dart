import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numfu/screen/res.dart';
import 'package:numfu/utility/app_controller.dart';
import 'package:numfu/utility/my_constant.dart';
import 'package:numfu/widgets/widget_image_network.dart';

class BuildRes extends StatelessWidget {
  const BuildRes({
    Key? key,
    required this.res1,
    required this.res2,
    required this.res3,
  }) : super(key: key);

  final Card res1;
  final Card res2;
  final Card res3;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(
              '## restautantModels ===> ${appController.restaurantModels.length}');
          return appController.restaurantModels.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: appController.restaurantModels.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(Res(restaurantModel: appController.restaurantModels[index],));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: WidgetImageNetwork(
                                urlImage:
                                    '${MyCostant.domain}/${appController.restaurantModels[index].company_logo}',
                                size: 150,
                              ),
                            ),
                            Text(
                                appController.restaurantModels[index].res_name),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
}
