import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/screens/search/search.dart';
import 'package:lost_item/function/api.dart';
import 'package:lost_item/function/functions.dart';
// import 'package:lost_item/models/marketsModels/marketsOption/marketsCategories.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final api = Get.put(Api());
  final func = Get.put(Functions());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await api.getMarketsOption();
              api.initValue();
              await func.takeBookMark();
              Get.to(() => Search());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Icon(Icons.search),
            ),
          ),
        ],
        title: const Text(
          'Lost Item',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(),
      ),
      // bottomNavigationBar: const AdmobBanner(),
    );
  }
}
