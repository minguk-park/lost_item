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

  late Markets marketOptions;
  Rx<SearchResult?> searchResult = null.obs;
  TextEditingController searchController = TextEditingController();
  final ScrollController itemsListScrollController = ScrollController();

  Map<String, dynamic> itemsCode = <String, dynamic>{};
  List itemsCodeName = [];
  var itemsPageSize = 10;

  final searchData = <String, dynamic>{
    'searchWord': '',
    'selectCodeName': "강화 재료",
    'selectCode' : 0,
  }.obs;

  var itemsList = [].obs;
  var itemsTotalCount = 0;
  var totalPageNo = 0;
  var curPage = 1.obs;

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
    itemsList.value = [];
    itemsTotalCount = 0;
    totalPageNo = 0;
    curPage.value = 1;

    update();
  }

  selectDialog(index) {
    initValue();
    String selectName = itemsCodeName[index];
    searchData['selectCodeName'] = selectName;
    searchData['selectCode'] = itemsCode[selectName];
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
      itemsCode.clear();
      itemsCodeName.clear();
      var responseData = await response.stream.bytesToString();
      var marketOptionsMap = jsonDecode(responseData);
      marketOptions = Markets.fromJson(marketOptionsMap);

      marketOptions.categories?.forEach((element) {
        itemsCode.addEntries({element.codeName!: element.code}.entries);
        itemsCodeName.add(element.codeName!);
      });

      searchData['selectCode'] = itemsCode[searchData['selectCodeName']];

    } else {
      switch (response.statusCode) {
        case 401:
        default:
          print('getMarketsOption: 알 수 없는 오류');
          break;
      }
    }
  }

  Future<void> postMarketsSearch(
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

      itemsTotalCount = searchResult.value?.totalCount ?? 0;
      if (itemsTotalCount != 0) {
        totalPageNo = itemsTotalCount ~/ itemsPageSize;
        if (itemsTotalCount % itemsPageSize != 0) {
          totalPageNo = totalPageNo + 1;
        }
      }
      searchResult.value?.items?.forEach((element) {
        itemsList.add(element);
      });
      searchData['searchWord'] = search;

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

  Future<void> postMarketsSearchPagenation() async {
    if (totalPageNo < curPage.value) return;
    curPage = curPage + 1;
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
        "PageNo": curPage.value,
      }),
    );

    if (response.statusCode == 200) {
      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;

      searchResult.value?.items?.forEach((element) {
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
