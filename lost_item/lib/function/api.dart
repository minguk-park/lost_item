import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lost_item/models/marketsModels/marketsSearch/searchResult.dart';
import 'package:lost_item/models/marketsModels/marketsSearch/searchResultItems.dart';
import 'package:lost_item/secret.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/marketsModels/marketsOption/markets.dart';

class Api extends GetxController {
  late Markets marketOptions;
  Rx<SearchResult?> searchResult = null.obs;
  TextEditingController searchController = TextEditingController();

  var itemsCode = [].obs;
  var items = [].obs;

  //카테고리당 3번씩 요청 -> 카테고리당 최대 30개씩 검색결과가 노출
  var requestPerCategory = 3;
  var itemsPageSize = 10;
  var itemsTotalCount = 0;

  Future<void> getMarketsOption() async {
    var headers = {
      'Accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
    };

    var request = http.Request(
      'GET',
      Uri.parse(Env.marketOptions),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var marketOptionsMap = jsonDecode(responseData);
      marketOptions = Markets.fromJson(marketOptionsMap);

      marketOptions.categories?.forEach((element) {
        itemsCode.add(element.code);
      });
    } else {
      // print(response.reasonPhrase);
      switch (response.statusCode) {
        case 401:
        // Fluttertoast.showToast(msg: '잘못된 회원정보입니다. 다시 로그인해주세요.');
        // final authController = Get.put(AuthGetX());
        // authController.authClear();
        // break;
        default:
          print('getMarketsOption: 알 수 없는 오류');
          break;
      }
    }
  }

// post body
// {
//   "Sort": "GRADE",
//   "CategoryCode": 0,           필수
//   "CharacterClass": "string",
//   "ItemTier": 0,
//   "ItemGrade": "string",
//   "ItemName": "string",
//   "PageNo": 0,
//   "SortCondition": "ASC"
// }
  Future<void> postMarketsSearch(String saerch) async {
    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(Env.marketSearch),
      headers: headers,
      body: json.encode({
        "CategoryCode": 50000,
        "ItemName": saerch,
      }),
    );

    if (response.statusCode == 200) {
      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;
      itemsTotalCount = searchResult.value?.totalCount ?? 0;

      if (itemsTotalCount > requestPerCategory) {
        itemsTotalCount = requestPerCategory;
      }

      update();
    } else {
      print(response.statusCode);
      switch (response.statusCode) {
        case 401:
        // Fluttertoast.showToast(msg: '잘못된 회원정보입니다. 다시 로그인해주세요.');
        // final authController = Get.put(AuthGetX());
        // authController.authClear();
        // break;
        default:
          print('postMarketsSearch: 알 수 없는 오류');
          break;
      }
    }
  }

  void allItemSearch(String saerch) {}

  void getAuctionsOption() {}
}
