import 'package:fluttertoast/fluttertoast.dart';

class ExceptionMsg {
  eMsg(int statusCode) {
    switch (statusCode) {
      case 400:
        Fluttertoast.showToast(msg:"$statusCode: Bad Request");
        break;
      case 401:
        Fluttertoast.showToast(msg:"$statusCode: Unauthorized");
        break;
      case 403:
        Fluttertoast.showToast(msg:"$statusCode: Forbidden");
        break;
      case 404:
        Fluttertoast.showToast(msg:"$statusCode: Not Found");
        break;
      case 415:
        Fluttertoast.showToast(msg:"$statusCode: Unsupported Media Type");
        break;
      case 429:
        Fluttertoast.showToast(msg:"$statusCode: Rate Limit Exceeded");
        break;
      case 500:
        Fluttertoast.showToast(msg:"$statusCode: Internal Server Error");
        break;
      case 502:
        Fluttertoast.showToast(msg:"$statusCode: Bad Gateway");
        break;
      case 503:
        Fluttertoast.showToast(msg:"$statusCode: Service Unavailable");
        break;
      case 504:
        Fluttertoast.showToast(msg:"$statusCode: Gateway Timeout");
        break;
      default:
        Fluttertoast.showToast(msg:"$statusCode: 알 수 없는 오류");
        break;
    }
  }
}