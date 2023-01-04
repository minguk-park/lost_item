import 'dart:convert';

import 'package:get/get.dart';
import 'package:lost_item/models/marketsModels/marketsSearch/searchResult.dart';
import 'package:lost_item/secret.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/marketsModels/marketsOption/markets.dart';

class Api extends GetxController {
  late Markets marketOptions;
  Rx<SearchResult?> searchResult = null.obs;

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
      // print('Categories: ' + marketOptions.categories!.length.toString());
      // print('ItemGrades: ' + marketOptions.itemGrades.toString());
      // print('ItemTiers: ' + marketOptions.itemTiers.toString());
      // print('Classes: ' + marketOptions.classes.toString());
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
//   "SortCondition": "ASC"       필수
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
      // var responseData = await response.stream.bytesToString();
      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;
      print('searchResultItems: ${searchResult.value!.totalCount}');
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

  void getAuctionsOption() {}
}
