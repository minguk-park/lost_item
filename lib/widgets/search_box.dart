import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lost_item/utils/market_search.dart';

final api = Get.put(MarketSearch());

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
  api.postMarketsSearch(text, api.selectCode.value, "");
  api.searchResult.refresh();
}
