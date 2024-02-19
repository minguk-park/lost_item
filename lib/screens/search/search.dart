import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/widgets/list_box.dart';
import 'package:lost_item/widgets/search_box.dart';
import 'package:lost_item/widgets/selet_dialog.dart';
import 'package:lost_item/utils/api.dart';
import 'package:lost_item/utils/functions.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final api = Get.put(Api());

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
      body: GetBuilder<Api>(
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
                          defaultSelectDialog(api.itemsCodeName,
                              Functions().selectDialog, buildContext);
                        },
                        child: Obx(
                          () => Container(
                            width: 70,
                            child: Center(
                              child: Text(api.selectCodeName.value),
                            ),
                          ),
                        ),
                      ),
                      defaultSearchBox(Functions().searchController, searchOnSubmit),
                      InkWell(
                        onTap: () async {
                          print('tap icon');
                          await api.postMarketsSearch(Functions().searchController.text,
                              api.selectCode.value, "");
                        },
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: api.itemsListScrollController,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        api.searchResult.value == null
                            ? 0
                            : api.itemsList.length,
                        (index) {
                          var itemMap = api.itemsList[index];
                          var createdBookmarkInfo = Functions().createItemInfo(
                            api.selectCode.value,
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
