import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numfu/screen/Favorite.dart';
import 'package:numfu/screen/carousel.dart';
import 'package:numfu/screen/location.dart';
import 'package:numfu/screen/login.dart';
import 'package:numfu/screen/profile.dart';
import 'package:numfu/screen/promotion.dart';
import 'package:numfu/screen/res.dart';
import 'package:numfu/screen/select_address.dart';
import 'package:numfu/screen/wallet.dart';
import 'package:numfu/state/build_address.dart';
import 'package:numfu/state/build_res.dart';
import 'package:numfu/utility/app_controller.dart';
import 'package:numfu/utility/app_service.dart';
import 'package:numfu/utility/my_constant.dart';
import 'package:numfu/utility/sqlite_helper.dart';
import 'package:numfu/widgets/widget_show_icon_cart.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:badges/badges.dart' as badges;

class Index extends StatefulWidget {
  static const routeName = '/';

  const Index({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
    AppService().readAllRestaurant();
  }

  Future<Null> readApiShop() async {
    String apiGetproductWhereIDBuyyer =
        '${MyCostant.domain}/getProductWhereIdSeller.php';
    await Dio().get(apiGetproductWhereIDBuyyer).then((value) {
      // print('value ==> $value');
      var result = json.decode(value.data);
      // print('result = $result');
      for (var item in result) {
        print('item ==> $item');
        // UserModel model = UserModel.fromMap(item);
        // print('name ==> ${model.name}');
      }
    });
  }

  /*final user = FirebaseAuth.instance.currentUser!;*/
  var res1 = new Card(
    child: Column(children: <Widget>[
      Image.asset(
        'img/1.1.jpg',
        height: 150,
        width: 150,
      )
    ]),
  );
  var res2 = new Card(
    child: Column(children: <Widget>[
      Image.asset(
        'img/1.2.jpg',
        height: 150,
        width: 150,
      )
    ]),
  );
  var res3 = new Card(
    child: Column(children: <Widget>[
      Image.asset(
        'img/1.3.jpg',
        height: 150,
        width: 150,
      )
    ]),
  );

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(
              '## restautantModels ===> ${appController.restaurantModels.length}');
          print('## positions --> ${appController.positions.length}');
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: GetX(
                init: AppController(),
                builder: (AppController appController) {
                  print(
                      'sqLiteModels --> ${appController.sqliteModels.length}');
                  return Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: Text(
                        "Numfu Deli",
                        style: GoogleFonts.khand(
                            textStyle: TextStyle(fontSize: 36)),
                      ),
                      actions: [
                        const WidgetIconCart(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Favorite();
                            }));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 255, 7, 40),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.clear().then((value) {
                              SQLiteHelper().deleteAlldata();
                              Get.offAll(const Login());
                            });
                          },
                          icon: const Icon(
                            Icons.exit_to_app,
                            color: Color.fromARGB(255, 255, 7, 40),
                          ),
                        ),
                      ],
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    backgroundColor: Colors.white,
                    body: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Container(
                          child: ListView(
                            children: [
                              const BuildAdress(),
                              buildFirstName(size),
                              SizedBox(
                                height: 20,
                              ),
                              Carousel(),
                              buildPro(),
                              Text(
                                'ลดสุดคุ้ม 60%',
                                style: MyCostant().h2Style(),
                              ),
                              Text(
                                'ลดสูงสุด 60 บ. ใส่รหัส GGWP',
                                style: MyCostant().h3Style(),
                              ),
                              BuildRes(res1: res1, res2: res2, res3: res3),
                            ],
                          ),
                        )),
                  );
                }),
          );
        });
  }

  MaterialButton buildSignout() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Login();
        }));
      },
      color: Colors.deepPurple[200],
      child: Text('sign out'),
    );
  }

  MaterialButton buildPro() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return promotion();
        }));
      },
      color: MyCostant.light,
      child: Text(
        'คูปองส่วนลดอาหาร                                 ดู',
        style: MyCostant().h7button(),
      ),
    );
  }

  Row buildFirstName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.82,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyCostant().h4Style(),
              labelText: 'กินอะไรดี?',
              prefixIcon: Icon(Icons.search),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyCostant.dark, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyCostant.light, width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.1,
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.list),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyCostant.dark, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyCostant.light, width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  Container buildtitle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Numfu Delivery",
            style: GoogleFonts.khand(textStyle: TextStyle(fontSize: 36)),
          ),
        ],
      ),
    );
  }
}

class buildtitle2 extends StatelessWidget {
  const buildtitle2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Delivery",
            style: GoogleFonts.khand(textStyle: TextStyle(fontSize: 36)),
          ),
        ],
      ),
    );
  }
}
