

import 'package:dio/dio.dart';
import 'package:manipuling_api/src/shared/constants.dart';
import 'package:manipuling_api/src/shared/custom_dio/interceptors.dart';
class CustomDio extends Dio{


  CustomDio(){
    options.baseUrl = BASE_URL;
    interceptors.add(CustomIntercetors());
    options.connectTimeout = 5000;
  }

}