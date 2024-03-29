import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/screens/search/search.dart';
import 'package:lost_item/utils/exception_msg.dart';
import 'package:lost_item/utils/market_search.dart';
import 'package:lost_item/utils/book_mark.dart';
import 'package:lost_item/widgets/list_box.dart';
// import 'package:lost_item/models/marketsModels/marketsOption/marketsCategories.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final marketSearch = Get.put(MarketSearch());

  final bookMark = Get.put(BookMark());
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
              await bookMark.refreshBookMark();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Icon(Icons.refresh),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await marketSearch.getMarketsOption();
              marketSearch.initValue();
              await bookMark.takeBookMark();
              Get.to(() => Search());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
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
      body: GetBuilder<BookMark>(
        builder: (context) {
          refresh() async {
            var errorCode = await bookMark.refreshBookMark();
            if(errorCode != 200) {
                ExceptionMsg().eMsg(errorCode);
            }
          }

          return Obx(() => SafeArea(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView(
                children: List.generate(
                  bookMark.itemsList.isEmpty
                      ? 0
                      : bookMark.itemsList.length,
                  (index) {
                    var itemMap = bookMark.itemsList[index];
                    var createdBookmarkInfo = bookMark.createItemInfo(
                      marketSearch.searchData['selectCode'],
                      itemMap.id,
                      itemMap.grade,
                      itemMap.name,
                    );
                    return defaultListBox(
                      itemMap.icon,
                      itemMap.name,
                      itemMap.yDayAvgPrice,
                      itemMap.recentPrice,
                      itemMap.currentMinPrice,
                      itemMap.tradeRemainCount,
                      createdBookmarkInfo,
                    );
                  },
                ),
              ),
            ),
          ));
        }
      ),
      // bottomNavigationBar: const AdmobBanner(),
    );
  }
}
