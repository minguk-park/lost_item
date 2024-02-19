import 'package:get/get_connect.dart';
import 'package:lost_item/env.dart';
import 'package:lost_item/secret.dart';

class GetConnectTest extends GetConnect {
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      request.headers['authorization'] = 'Bearer ${Secret.devApiKey}';
      return request;
    });

    super.onInit();
  }

  /// 테스트 코드
  test() async {
    Response res = await get(Env.marketOptions);
    if (res.statusCode == 200) {
      print('GetConnectTest:' + res.bodyString.toString());
    }
  }
}
