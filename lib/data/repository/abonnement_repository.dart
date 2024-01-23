import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http/http.dart' as http;

class AbonnementRepository {
  static String stateInfoUrl = 'https://tag.trans-academia.cd/';

  static Future<List> getAbonnementData() async {
    return await http.post(
        Uri.parse("${stateInfoUrl}Trans_Liste_Abonement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      return data['donnees'];
    }).catchError((onError) {});
  }

  static Future<List> getDataListAbonnementCache() async {
    final formData = FormData.fromMap({'App_name': "app", 'token': "2022"});
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(
            CacheConfig(baseUrl: "${stateInfoUrl}Trans_Liste_Abonement.php"))
        .interceptor);
    var response = await dio.post("${stateInfoUrl}Trans_Liste_Abonement.php",
        data: formData,
        options: buildCacheOptions(const Duration(hours: 2)));
    var data = response.data;
    return data['donnees'];
  }

    static Future<List> getDataListPaymentCache() async {
    final formData = FormData.fromMap({'App_name': "app", 'token': "2022"});
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(
            CacheConfig(baseUrl: "${stateInfoUrl}Liste_operator_paiement.php"))
        .interceptor);
    var response = await dio.post("${stateInfoUrl}Liste_operator_paiement.php",
        data: formData,
        options: buildCacheOptions(const Duration(hours: 2))
        );
    var data = response.data;
    return data['donnees'];
  }
}
