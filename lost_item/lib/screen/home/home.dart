import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/Screen/search/search.dart';
import 'package:lost_item/function/api.dart';
import 'package:lost_item/models/marketsModels/marketsOption/marketsCategories.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Api api = Api();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: InkWell(
        //   splashColor: Colors.transparent,
        //   highlightColor: Colors.transparent,
        //   // onTap: () {
        //   //   exitDialog();
        //   // },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 15.0,
        //     ),
        //     child: Icon(Icons.search),
        //   ),
        // ),
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              api.getMarketsOption();
              // GetConnectTest().test();
              api.postMarketsSearch('조화');
              // getTest.test();
              Get.to(() => const Search());
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
