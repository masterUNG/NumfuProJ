import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:numfu/model/address_model.dart';
import 'package:numfu/model/product_model.dart';
import 'package:numfu/model/restaurant_model.dart';
import 'package:numfu/model/user_model.dart';
import 'package:numfu/utility/app_controller.dart';
import 'package:numfu/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> findCurrentUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var datas = preferences.getStringList('datas');
    print('##16april datas at findCurrent --> $datas');

    if (datas != null) {
      String url =
          'https://www.androidthai.in.th/edumall/getCustomerWhereUser.php?isAdd=true&cust_email=${datas[5]}';
      await Dio().get(url).then((value) {
        for (var element in json.decode(value.data)) {
          UserModel userModel = UserModel.fromMap(element);
          appController.currentUserModels.add(userModel);
        }
      });
    }
  }

  void processCalculateFood() {
    appController.total.value = 0;

    for (var element in appController.sqliteModels) {
      appController.total.value =
          appController.total.value + int.parse(element.sum);
    }
  }

  String calculatePriceDistance({required double distance}) {
    String priceDistance = '10';
    if (distance > 5) {
      int num = distance.round();
      num = num - 5;
      priceDistance = (10 + (num * 10)).toString();
    }
    return priceDistance;
  }

  Future<void> readProductWhereResId({required String res_id}) async {
    if (appController.productModels.isNotEmpty) {
      appController.productModels.clear();
    }

    String url =
        'https://www.androidthai.in.th/edumall/getFoodWhereIdRes.php?isAdd=true&res_id=$res_id';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        for (var element in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(element);
          appController.productModels.add(productModel);
        }
      }
    });
  }

  Future<void> findPostion() async {
    Position position = await Geolocator.getCurrentPosition();
    appController.positions.add(position);
  }

  Future<void> readAllRestaurant() async {
    findPostion().then((value) async {
      if (appController.restaurantModels.isNotEmpty) {
        appController.restaurantModels.clear();
      }

      String urlApi = '${MyCostant.domain}/getAllrestaurant.php';
      print('## urlApi --> $urlApi');

      await Dio().get(urlApi).then((value) {
        print('## datas --> ${appController.datas}');

        print('## value ==> $value');

        var rawMap = <Map<String, dynamic>>[];

        for (var element in json.decode(value.data)) {
          RestaurantModel restaurantModel = RestaurantModel.fromMap(element);
          if (restaurantModel.res_status == '1') {
            double distance = calculateDistance(
                appController.positions.last.latitude,
                appController.positions.last.longitude,
                double.parse(restaurantModel.latitude),
                double.parse(restaurantModel.longitude));

            print('## distance --> $distance');

            Map<String, dynamic> map = restaurantModel.toMap();
            map['distance'] = distance;

            // print('## map --> $map');
            rawMap.add(map);

            appController.restaurantModels.add(restaurantModel);
          }
        }

        print('## before rawMap --> $rawMap');

        rawMap.sort(
          (a, b) => a['distance'].compareTo(b['distance']),
        );

        print('## after rawMap --> $rawMap');

        for (var element in rawMap) {
          RestaurantModel model = RestaurantModel.fromMap(element);
          appController.restaurantModels.add(model);
        }
      });
    });
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  Future<AddressModel> findDataAddress(
      {required double lat, required double lng}) async {
    String urlAPI =
        'https://api.longdo.com/map/services/address?lon=$lng&lat=$lat&noelevation=1&key=cda17b2e1b8010bdfc353a0f83d59348';
    var result = await Dio().get(urlAPI);
    AddressModel addressModel = AddressModel.fromMap(result.data);
    print('## addressModel --> ${addressModel.toMap()}');
    return addressModel;
  }
}
