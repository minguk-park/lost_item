import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect.dart';
import 'package:lost_item/secret.dart';
import 'package:http/http.dart' as http;

import 'package:lost_item/models/markets_models/markets_option/markets.dart';
import 'package:lost_item/models/markets_models/markets_search/search_result.dart';

import '../env.dart';

class MarketSearch extends GetxController{
  // final GetConnect connect = Get.find<GetConnect>();

  TextEditingController searchController = TextEditingController();
  final ScrollController itemsListScrollController = ScrollController();

  Rx<SearchResult?> searchResult = null.obs;
  late Markets marketOptions;

  final searchData = <String, dynamic>{
    'searchWord': '',
    'selectCodeName': "강화 재료",
    'selectCode' : 50000,
    'curPage' : 1,
  }.obs;

  //pagination
  var itemsPageSize = 10;
  var totalPageNo = 0;

  var itemsList = [].obs;

  @override
  void onInit() {
    // allowAutoSignedCert = true;
    // connect.httpClient.addRequestModifier<void>((request) {
    //   request.headers['Accept'] = 'application/json';
    //   request.headers['authorization'] = 'Bearer ${Secret.devApiKey}';
    //   return request;
    // });

    super.onInit();
    itemsListScrollEvent();
  }

  void itemsListScrollEvent() {
    itemsListScrollController.addListener(() async {
      if (itemsListScrollController.position.pixels ==
          itemsListScrollController.position.maxScrollExtent) {
        await postMarketsSearchPagenation();
      }
    });
  }

  initValue() {
    searchData['searchWord'] = '';
    searchData['curPage'] = 1;
    itemsList.value = [];
    totalPageNo = 0;

    update();
  }

  selectDialog(index) {
    initValue();
    var categories = marketOptions.categories;
    searchData['selectCodeName'] = categories[index].codeName;
    searchData['selectCode'] = categories[index].code;
    return;
  }

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

    } else {
      switch (response.statusCode) {
        case 401:
        default:
          print('getMarketsOption: 알 수 없는 오류');
          break;
      }
    }
  }

  Future<int> postMarketsSearch(
      String search, int categoryCode, String itemGrade) async {
    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(Env.marketSearch),
      headers: headers,
      body: json.encode({
        "CategoryCode": categoryCode,
        "ItemName": search,
        "ItemGrade": itemGrade,
      }),
    );

    if (response.statusCode == 200) {
      initValue();

      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;

      var itemsTotalCount = searchResult.value?.totalCount ?? 0;
      if (itemsTotalCount != 0) {
        totalPageNo = itemsTotalCount ~/ itemsPageSize;
        if (itemsTotalCount % itemsPageSize != 0) {
          totalPageNo = totalPageNo + 1;
        }
      }
      searchResult.value?.items.forEach((element) {
        itemsList.add(element);
      });
      searchData['searchWord'] = search;

      update();

      return 200;
    } else {
      return response.statusCode;
    }
  }

  Future<void> postMarketsSearchPagenation() async {
    if (totalPageNo < searchData['curPage']) return;
    searchData['curPage'] = searchData['curPage'] + 1;
    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(Env.marketSearch),
      headers: headers,
      body: json.encode({
        "CategoryCode": searchData['selectCode'],
        "ItemName": searchData['searchWord'],
        "PageNo": searchData['curPage'],
      }),
    );

    if (response.statusCode == 200) {
      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;

      searchResult.value?.items.forEach((element) {
        itemsList.add(element);
      });

      update();
    } else {
      print(response.statusCode);
      switch (response.statusCode) {
        case 401:
        default:
          print('postMarketsSearch: 알 수 없는 오류');
          break;
      }
    }
  }

  void allItemSearch(String saerch) {}

  void getAuctionsOption() {}
}
