import 'package:get/get.dart';
import 'package:food_delivery_clean_arch/src/core/utils/app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/params/api_request.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  late Map<String, String> _mainHeaders;
  final String appBaseUrl;
  final Map<String, String> _noTokenHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  ApiClient(this.appBaseUrl){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token= AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };

  }


  Future<Response> demand(APIRequestParams params) async{
    try {
      final response = await request(
        params.url,
        params.method.string,
        headers: params.headers,
        query: params.query,
        body: params.body,
      );
      return response;
    }catch(e){
        rethrow;
    }
  }

}