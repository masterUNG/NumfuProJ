import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:numfu/model/product_model.dart';
import 'package:numfu/model/restaurant_model.dart';
import 'package:numfu/model/sqlite_model.dart';
import 'package:numfu/model/user_model.dart';

class AppController extends GetxController {
  RxList<RestaurantModel> restaurantModels = <RestaurantModel>[].obs;
  RxList<String> datas = <String>[].obs;
  RxList<Position> positions = <Position>[].obs;
  RxList<ProductModel> productModels = <ProductModel>[].obs;
  RxInt amount = 1.obs;
  RxDouble distanceKm = 0.0.obs;
  RxList<SQLiteModel> sqliteModels = <SQLiteModel>[].obs;
  RxInt total = 0.obs;

  RxList<UserModel> currentUserModels = <UserModel>[].obs;
}
