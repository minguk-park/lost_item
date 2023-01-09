import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/components/listBox.dart';
import 'package:lost_item/components/searchBox.dart';
import 'package:lost_item/components/seletDialog.dart';
import 'package:lost_item/function/api.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  final api = Get.put(Api());

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        defaultSelectDialog();
                      },
                      child: Container(
                        child: Text('adf'),
                      ),
                    ),
                    defaultSearchBox(api.searchController, searchOnSubmit),
                    InkWell(
                      onTap: () async {
                        print('tap icon');
                        await api.postMarketsSearch(api.searchController.text);
                      },
                      child: const Icon(Icons.search),
                    ),
                  ],
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
                        (index) => defaultListBox(
                          api.itemsList[index].name,
                          api.itemsList[index].yDayAvgPrice,
                          api.itemsList[index].recentPrice,
                        ),
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
