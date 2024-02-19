import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/screens/search/search.dart';
import 'package:lost_item/utils/market_search.dart';
import 'package:lost_item/utils/book_mark.dart';
// import 'package:lost_item/models/marketsModels/marketsOption/marketsCategories.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final marketSearch = Get.put(MarketSearch());
  final func = Get.put(BookMark());

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
              await marketSearch.getMarketsOption();
              marketSearch.initValue();
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
