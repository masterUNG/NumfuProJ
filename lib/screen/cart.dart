// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:numfu/model/sqlite_model.dart';
import 'package:numfu/screen/ordering.dart';
import 'package:numfu/utility/app_controller.dart';
import 'package:numfu/utility/app_service.dart';
import 'package:numfu/utility/my_constant.dart';
import 'package:numfu/utility/my_dialog.dart';
import 'package:numfu/utility/sqlite_helper.dart';
import 'package:numfu/widgets/show_title.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    AppService().processCalculateFood();
    AppService().findCurrentUserModel();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ตะกร้าสินค้า',
          style: MyCostant().headStyle(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                MyDialog().normalDialog(
                    context, 'Empty Cart', 'Please Confirm for Empty Cart',
                    firstAction: TextButton(
                        onPressed: () {
                          SQLiteHelper().deleteAlldata().then((value) {
                            Get.back();
                            Get.back();
                          });
                        },
                        child: const Text('Confrim')));
              },
              icon: Icon(Icons.remove_shopping_cart_rounded))
        ],
      ),
      backgroundColor: Colors.white,
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                '##16april currentUserModel ---> ${appController.currentUserModels.length}');
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: appController.sqliteModels.isEmpty
                  ? const SizedBox()
                  : Container(
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 0,
                          ),
                          buildBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'สรุปคำสั่งซื้อ',
                            style: MyCostant().h2Style(),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: appController.sqliteModels.length,
                              itemBuilder: (context, index) => buildBoxmenu1(
                                  index: index,
                                  appController: appController,
                                  context: context)),

                          // buildBoxmenu1(),
                          // buildDivider(),
                          // buildBoxmenu2(),
                          buildDivider(),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'รวมค่าอาหาร',
                                style: MyCostant().h3Style(),
                              )),
                              Text(
                                '฿ ${appController.total.value}',
                                style: MyCostant().h3Style(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'ค่าจัดส่ง',
                                style: MyCostant().h3Style(),
                              )),
                              Text(
                                '฿ ${appController.sqliteModels.last.derivery}',
                                style: MyCostant().h3Style(),
                              ),
                            ],
                          ),
                          buildDivider(),
                          Text(
                            'รายละเอียดการชำระเงิน',
                            style: MyCostant().h2Style(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'ยอดเงินคงเหลือ',
                                style: MyCostant().h3Style(),
                              )),
                              Text(
                                appController.currentUserModels.isEmpty
                                    ? ''
                                    : '฿ ${(int.parse(appController.currentUserModels.last.wallet!) - int.parse(appController.currentUserModels.last.payment!))}',
                                style: MyCostant().h3Style(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'ยอดรวมทั้งหมด',
                                style: MyCostant().h2Style(),
                              )),
                              Text(
                                '฿ ${(int.parse(appController.sqliteModels.last.derivery) + appController.total.value)}',
                                style: MyCostant().h2Style(),
                              ),
                            ],
                          ),
                          buildEnter(
                            size: size,
                            appController: appController,
                          ),
                        ],
                      ),
                    ),
            );
          }),
    );
  }

  Container buildBox() {
    return Container(
      width: 400,
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0xffFF8126),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'จัดส่งที่                                    ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xffffffff),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "หอพักกัลยรัตน์ - Kanlayarat Dormitory",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "Soi Thawon Phruek, Lat Krabang, Lat Krabang, Bang...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        ' 0.8 กม. ',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Row buildAdd_remove1(
    {required int index,
    required AppController appController,
    required BuildContext context}) {
  return Row(
    children: [
      Container(
        width: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF5F4F4),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                int amountInt =
                    int.parse(appController.sqliteModels[index].amount);

                if (amountInt == 1) {
                  //delete product

                  MyDialog()
                      .normalDialog(context, 'Confirm Delete', 'Please Confirm',
                          firstAction: TextButton(
                              onPressed: () {
                                Get.back();
                                SQLiteHelper().deleteWhereId(
                                    id: appController.sqliteModels[index].id!);
                              },
                              child: const Text('Confirm')));
                } else {
                  amountInt--;

                  Map<String, dynamic> map =
                      appController.sqliteModels[index].toMap();

                  map['amount'] = amountInt.toString();
                  map['sum'] = (amountInt *
                          int.parse(appController.sqliteModels[index].price))
                      .toString();

                  SQLiteHelper()
                      .editData(
                          id: appController.sqliteModels[index].id!, map: map)
                      .then((value) {
                    AppService().processCalculateFood();
                  });
                }
              },
              icon: Icon(
                Icons.remove_circle,
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            Text(
              appController.sqliteModels[index].amount,
              style: MyCostant().h3Style(),
            ),
            IconButton(
              onPressed: () {
                int amountInt =
                    int.parse(appController.sqliteModels[index].amount);

                amountInt++;

                Map<String, dynamic> map =
                    appController.sqliteModels[index].toMap();

                map['amount'] = amountInt.toString();
                map['sum'] = (amountInt *
                        int.parse(appController.sqliteModels[index].price))
                    .toString();

                SQLiteHelper()
                    .editData(
                        id: appController.sqliteModels[index].id!, map: map)
                    .then((value) {
                  AppService().processCalculateFood();
                });
              },
              icon: const Icon(
                Icons.add_circle,
                color: Color(0xffFF8126),
              ),
            ),
          ],
        ),
      ),
      Text(
        '  ฿ ${appController.sqliteModels[index].sum}',
        style: MyCostant().h3_1Style(),
      ),
    ],
  );
}

Row buildAdd_remove2() {
  return Row(
    children: [
      Container(
        width: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF5F4F4),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.remove_circle,
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            Text(
              '1',
              style: MyCostant().h3Style(),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle,
                color: Color(0xffFF8126),
              ),
            ),
          ],
        ),
      ),
      Text(
        '  ฿ 50',
        style: MyCostant().h3_1Style(),
      ),
    ],
  );
}

Container buildBoxmenu1(
    {required int index,
    required AppController appController,
    required BuildContext context}) {
  return Container(
    width: 400,
    height: 100,
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${MyCostant.domain}${appController.sqliteModels[index].urlImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appController.sqliteModels[index].foodName,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  buildAdd_remove1(
                      index: index,
                      appController: appController,
                      context: context),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Container buildBoxmenu2() {
  return Container(
    width: 400,
    height: 100,
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("img/2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ก๋วยเต๊่ยวน้ำใส',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  buildAdd_remove2(),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Divider buildDivider() {
  return const Divider(
    height: 25,
    color: Color(0xff4A4949),
  );
}

class buildEnter extends StatelessWidget {
  const buildEnter({
    Key? key,
    required this.size,
    required this.appController,
  }) : super(key: key);

  final double size;
  final AppController appController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var idProducts = <String>[];
        var names = <String>[];
        var prices = <String>[];
        var amounts = <String>[];

        for (var element in appController.sqliteModels) {
          idProducts.add(element.id.toString());
          names.add(element.foodName);
          prices.add(element.price);
          amounts.add(element.amount);
        }

        String url =
            'https://www.androidthai.in.th/edumall/insertOrder.php?isAdd=true&idCustomer=${appController.currentUserModels.last.cust_id}&idShop=${appController.sqliteModels.last.resId}&idRidder=%23&dateTime=${DateTime.now().toString()}&idProducts=${idProducts.toString()}&names=${names.toString()}&prices=${prices.toString()}&amounts=${amounts.toString()}&total=${appController.total}&delivery=${appController.sqliteModels.last.derivery}&approveShop=%23&approveRider=%23';

        print('##16april url -----> $url');

        if (int.parse(appController.currentUserModels.last.wallet!) -
                int.parse(appController.currentUserModels.last.payment!) >=
            int.parse(appController.sqliteModels.last.derivery) +
                appController.total.value) {
          await Dio().get(url).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Ordering();
            }));
          });
        } else {
          MyDialog().normalDialog(context, 'Cannot Order', 'เงินไม่พอ',
              firstAction:
                  TextButton(onPressed: () {}, child: Text('เติมเงิน')));
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: size * 10,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: MyCostant.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "ยืนยันคำสั่งซื้อ",
            style: MyCostant().h5button(),
          ),
        ),
      ),
    );
  }
}
