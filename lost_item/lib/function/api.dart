import 'dart:convert';

import 'package:lost_item/secret.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/marketsModels/marketsOption/markets.dart';

class Api {
  late Markets marketOptions;

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
      // print('Categories: ' + marketOptions.categories![0].codeName.toString());
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

  void getAuctionsOption() {}
}
