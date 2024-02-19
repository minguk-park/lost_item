import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lost_item/utils/market_search.dart';

final marketSearch = Get.put(MarketSearch());

defaultSearchBox(controller, onSubmit) {
  return Flexible(
    child: TextField(
      controller: controller,
      onSubmitted: onSubmit,
      maxLines: 1,
    ),
  );
}

searchOnSubmit(String text) {
  marketSearch.postMarketsSearch(text, marketSearch.searchData['selectCode'], "");
  marketSearch.searchResult.refresh();
}
