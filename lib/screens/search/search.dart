import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/widgets/list_box.dart';
import 'package:lost_item/widgets/search_box.dart';
import 'package:lost_item/widgets/selet_dialog.dart';
import 'package:lost_item/utils/market_search.dart';
import 'package:lost_item/utils/book_mark.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final marketSearch = Get.put(MarketSearch());

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<MarketSearch>(
        builder: (context) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          defaultSelectDialog(marketSearch.itemsCodeName,
                              marketSearch.selectDialog, buildContext);
                        },
                        child: Obx(
                          () => SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(marketSearch.searchData['selectCodeName']),
                            ),
                          ),
                        ),
                      ),
                      defaultSearchBox(marketSearch.searchController, searchOnSubmit),
                      InkWell(
                        onTap: () async {
                          print('tap icon');
                          await marketSearch.postMarketsSearch(marketSearch.searchController.text,
                              marketSearch.searchData['selectCode'], "");
                        },
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: marketSearch.itemsListScrollController,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        marketSearch.searchResult.value == null
                            ? 0
                            : marketSearch.itemsList.length,
                        (index) {
                          var itemMap = marketSearch.itemsList[index];
                          var createdBookmarkInfo = BookMark().createItemInfo(
                            marketSearch.searchData['selectCode'],
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
