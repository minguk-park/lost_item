import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lost_item/components/listBox.dart';
import 'package:lost_item/components/searchBox.dart';
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
                Column(
                  children: [
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
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        api.searchResult.value == null
                            ? 0
                            : api.searchResult.value!.totalCount ?? 0,
                        (index) => defaultListBox(
                          api.searchResult.value!.items![index].name!,
                          api.searchResult.value!.items![index].yDayAvgPrice!,
                          api.searchResult.value!.items![index].recentPrice!,
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
