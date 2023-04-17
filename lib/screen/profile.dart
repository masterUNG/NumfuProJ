import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numfu/screen/login.dart';
import 'package:numfu/utility/app_controller.dart';
import 'package:numfu/utility/app_service.dart';
import 'package:numfu/utility/my_constant.dart';

import 'package:numfu/widgets/show_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  static const routeName = '/';

  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    AppService().findCurrentUserModel();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('userModel --> ${appController.currentUserModels.length}');
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'ข้อมูลส่วนตัว',
                style: MyCostant().headStyle(),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: appController.currentUserModels.isEmpty
                ? const SizedBox()
                : Center(
                    child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildImage(size),
                        buildTextname(appController: appController),
                        buildedit(),
                        buildFirstName(size),
                        buildLastName(size),
                        buildphone(size),
                        buildSignout(),
                      ],
                    ),
                  )),
          );
        });
  }

  Container buildedit() {
    return Container(
        margin: EdgeInsets.only(right: 290),
        child: Text(
          'แก้ไขข้อมูล',
          style: MyCostant().h3Style(),
        ));
  }

  Text buildTextname({required AppController appController}) {
    return Text(
      appController.currentUserModels.last.cust_firstname,
      style: MyCostant().h2Style(),
    );
  }

  MaterialButton buildSignout() {
    return MaterialButton(
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear().then(
              (value) => Navigator.pushNamedAndRemoveUntil(
                  context, MyCostant.routelogin, (route) => false),
            );
      },
      color: MyCostant.red,
      child: Text(
        '                    ออกจากระบบ                    ',
        style: MyCostant().h5button(),
      ),
    );
  }
}

Row buildImage(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          margin: EdgeInsets.only(top: 20),
          height: size * 0.3,
          child: ShowImage(
            path: MyCostant.logo,
          )),
    ],
  );
}

Row buildFirstName(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        width: size * 0.9,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color.fromARGB(255, 102, 102, 102)),
            ),
            labelStyle: MyCostant().h4Style(),
            labelText: 'ชื่อจริง',
            hintText: "กรอกชื่อของคุณ",
            suffixIcon: Icon(Icons.person),
          ),
        ),
      ),
    ],
  );
}

Row buildLastName(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        width: size * 0.9,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color.fromARGB(255, 102, 102, 102)),
            ),
            labelStyle: MyCostant().h4Style(),
            labelText: 'นามสกุล',
            hintText: "กรอกนามสกุลของคุณ",
            suffixIcon: Icon(Icons.person),
          ),
        ),
      ),
    ],
  );
}

Row buildphone(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        width: size * 0.9,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color.fromARGB(255, 102, 102, 102)),
            ),
            labelStyle: MyCostant().h4Style(),
            labelText: 'เบอร์โทรศัพท์',
            suffixIcon: Icon(Icons.person),
          ),
        ),
      ),
    ],
  );
}
