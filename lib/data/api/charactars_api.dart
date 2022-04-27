import 'package:dio/dio.dart';
import 'package:flutter_breaking/constant/strings.dart';

class CharactorApi {
  late Dio dio;

  CharactorApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharactors() async {
    try {
      Response responce = await dio.get('characters');
      print(responce.data.toString());
      return responce.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
