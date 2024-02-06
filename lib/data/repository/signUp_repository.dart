// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:icecream_service/utils/string.util.dart';

class SignUpRepository {

 static Future<Map<String, dynamic>> signupAgentCream(Map data) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("https://iglace.eyanofinance.org/api/v1/auth/signup"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      Map? responseData = responseJson['data'];
      String? message = responseJson['message'];
      //prefs.setString("token", token.toString());
      return {"status": statusCode, "data": responseData, "message": message};
    } else if (statusCode == 400) {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }


   static Future<Map<String, dynamic>> loginCream(Map data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse("https://iglace.eyanofinance.org/api/v1/auth/login"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      // String? token = responseJson['token'];
      String? message = responseJson['message'];
      Map? data = responseJson['data'];

      // prefs.setString("token", token.toString());
      return {
        // "token": token,
        "status": statusCode,
        "message": message,
        "data": data
      };
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

    static Future<Map<String, dynamic>> gettAllAgentCream() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/user'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

    static Future<Map<String, dynamic>> gettAllProductCream() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/product'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

   static Future<Map<String, dynamic>> gettAllProductBySite(int idSite) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/dashboard/sale_site_price?ID_sales_site=${idSite}'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

   static Future<Map<String, dynamic>> gettAllSIteCream() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/dashboard/sale_site'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

    static Future<Map<String, dynamic>> gettAllVolumeCream() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/dashboard/capacity_unit'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

   static Future<Map<String, dynamic>> gettAllOperationCream() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/operation/nature'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

   static Future<Map<String, dynamic>> gettAllOperationReasonCream() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/operation/reason'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> createProductCream(Map data) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("https://iglace.eyanofinance.org/api/v1/product"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      Map? responseData = responseJson['data'];
      String? message = responseJson['message'];
      //prefs.setString("token", token.toString());
      return {"status": statusCode, "data": responseData, "message": message};
    } else if (statusCode == 400) {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> createSiteCream(Map data) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("https://iglace.eyanofinance.org/api/v1/dashboard/sale_site"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      Map? responseData = responseJson['data'];
      String? message = responseJson['message'];
      //prefs.setString("token", token.toString());
      return {"status": statusCode, "data": responseData, "message": message};
    } else if (statusCode == 400) {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

   static Future<Map<String, dynamic>> createCommandeCream(Map data) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("https://iglace.eyanofinance.org/api/v1/order"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      Map? responseData = responseJson['data'];
      String? message = responseJson['message'];
      //prefs.setString("token", token.toString());
      return {"status": statusCode, "data": responseData, "message": message};
    } else if (statusCode == 400) {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

    static Future<Map<String, dynamic>> getCommandesByIdAgent(String? id) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/order?ID_ordering_agent=${id}'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }


   static Future<Map<String, dynamic>> getOperationsByIdAgent(String? id) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://iglace.eyanofinance.org/api/v1/operation?ID_agent=${id}'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }












  // static Future<Map<String, dynamic>> login(String login, String pwd) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'GET', Uri.parse("${StringFormat.baseUrl}api/user.php/parent"));

  //   request.body = json.encode({"login": login, "pwd": pwd});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   String responseBody = await response.stream.bytesToString();

  //   Map<String, dynamic> responseJson = json.decode(responseBody);

  //   int statusCode = responseJson['code'];

  //   if (statusCode == 200) {
  //     String? token = responseJson['token'];
  //     String? message = responseJson['message'];
  //     Map? data = responseJson['data'];

  //     prefs.setString("token", token.toString());
  //     return {
  //       "token": token,
  //       "status": statusCode,
  //       "message": message,
  //       "data": data
  //     };
  //   } else {
  //     String message = responseJson['message'];
  //     return {"status": statusCode, "message": message};
  //   }
  // }

  static Future<Map<String, dynamic>> getEtablissementsKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('${StringFormat.baseUrl}api/etablissement.php'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getEnfantsDuParent(
      String idParent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'GET',
      Uri.parse('${StringFormat.baseUrl}api/student.php/parent/$idParent'),
    );
    request.headers.addAll(headers);
    request.body = json.encode({"Id_parent": "15"});

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      Map<String, dynamic> responseJson = json.decode(responseBody);

      int? statusCode = responseJson['code'];

      if (statusCode == 200) {
        String? message = responseJson['message'];
        Map<String, dynamic>? data = responseJson['data'];
        return {"status": statusCode, "message": message, "data": data};
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> getEnfantsDuParent2(
      String idParent) async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await dio.get(
        '${StringFormat.baseUrl}api/student.php/parent/15',
      );

      Map<String, dynamic> responseJson = response.data;
      int? statusCode = responseJson['code'];

      if (statusCode == 200) {
        String? message = responseJson['message'];
        Map<String, dynamic>? data = responseJson['data'];

        return {"status": statusCode, "message": message, "data": data};
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> getSectionKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('${StringFormat.baseUrl}api/etablissement.php/section'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getOptionKelasi(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${StringFormat.baseUrl}api/etablissement.php/section/${id}/option'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message, "data": []};
    }
  }

  static Future<Map<String, dynamic>> getLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse("${StringFormat.baseUrl}api/etablissement.php/level"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }


 static Future<Map<String, dynamic>> getProvinceKelasi() async {
  var request = http.Request(
      'GET', Uri.parse("${StringFormat.baseUrlCream}api/v1/address/province"));

  request.body = json.encode({"idParent": ""});

  http.StreamedResponse response = await request.send();
  String responseBody = await response.stream.bytesToString();

  Map<String, dynamic> responseJson = json.decode(responseBody);

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(responseJson["data"]);
    return {"status": response.statusCode, "data": data};
  } else {
    return {"status": response.statusCode};
  }
}


 static Future<Map<String, dynamic>> getVilleKelasi(String idProvince) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.Request('GET', Uri.parse("${StringFormat.baseUrlCream}api/v1/address/province/${idProvince}"));

    // request.headers.addAll(headers);
    request.body = json.encode({"province_id": idProvince});

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    List<dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List? data = responseJson;
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> getCommuneKelasi(String idVille) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request =
         http.Request('GET', Uri.parse("${StringFormat.baseUrlCream}api/v1/address/ville/${idVille}"));

    // request.headers.addAll(headers);
    request.body = json.encode({"ville_id": idVille});

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    List<dynamic> responseJson = json.decode(responseBody);

    if (response.statusCode == 200) {
      List? data = responseJson;
      return {"status": response.statusCode, "data": data};
    } else {
      return {"status": response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> signup(
      Map data, BuildContext context) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("${StringFormat.baseUrl}api/user.php/parent"));

    request.body = json.encode({
      "nom": data["nom"].toString(),
      "prenom": data["prenom"].toString(),
      "postnom": data["postnom"].toString(),
      "sexe": data["sexe"].toString(),
      "telephone": data["phone"].toString(),
      "avenue": data["avenue"].toString(),
      "numero": data["numeroAdresse"].toString(),
      "email": data["email"].toString(),
      "Id_province": data["Id_province"].toString(),
      "Id_commune": data["Id_commune"].toString(),
      "Id_ville": data["Id_ville"].toString(),
      "Id_user_created_at": 1,
      "pwd": data["password"].toString(),
      "pwd_confirm": data["confirmPassword"].toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      String? token = responseJson['token'];
      Map? data = responseJson['data'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token.toString());
      return {"token": token, "status": statusCode, "data": data};
    } else if (statusCode == 400) {
      String message = "Désolé ! Ce numéro est déjà associé à un compte.";
      return {"status": statusCode, "message": message};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> signupEnfant(Map data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request(
          'POST', Uri.parse("${StringFormat.baseUrl}api/student.php"));
      request.headers.addAll(headers);
      print(data);

      request.body = json.encode({
        "nom": data["nom"].toString(),
        "postnom": data["postnom"].toString(),
        "prenom": data["prenom"].toString(),
        "sexe": data["sexe"].toString(),
        "Id_etablissement": data["Id_etablissement"].toString(),
        "Id_option": data["Id_option"].toString(),
        "Id_level": data["Id_level"].toString(),
        "Id_user_created_at": data["userId"].toString(),
        "Id_parent": data["parentId"].toString(),
      });

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(responseBody);

      int statusCode = responseJson['code'];

      if (statusCode == 201) {
        return {
          "status": statusCode,
        };
      } else {
        String message = responseJson['message'];
        return {"status": statusCode, "message": message};
      }
    } catch (e) {
      return {"status": 500, "message": "Erreur interne du serveur"};
    }
  }

  static Future<Map<String, dynamic>> loginToken(
      String login, String pwd) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET', Uri.parse("${StringFormat.baseUrl}api/user.php/parent"));

    request.body = json.encode({"login": login, "pwd": pwd});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String token = responseJson['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token.toString());
      return {
        "token": token,
      };
    } else {
      return {"status": statusCode};
    }
  }

  static Future<Map<String, dynamic>> checkOtp(Map data) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST', Uri.parse("${StringFormat.baseUrl}api/user.php/parent/otp"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      return {
        "status": statusCode,
        "message": responseJson['message'],
      };
    } else {
      return {"status": statusCode, "message": responseJson['message']};
    }
  }

  static Future<List> getProvincesKelasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers = {'Authorization': 'bearer ${token}'};

    var request = http.Request(
        'GET', Uri.parse('${StringFormat.baseUrl}api/address.php'));
    request.headers.addAll(headers);
    request.body = json.encode({"idParent": ""});

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];
    List<dynamic> resultList = responseJson.values.toList();

    if (statusCode == 200) {
      return resultList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<List> getUniversiteData() async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Etablisement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      return data['donnees'];
    }).catchError((onError) {});
  }

  static Future<List> getFaculteData({required String idUniversite}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Facultes.php"),
        body: {
          'App_name': "app",
          'token': "2022",
          "id": idUniversite
        }).then((response) {
      var data = json.decode(response.body);

      return data['donnees'] ?? [];
    }).catchError((onError) {});
  }

  static Future<List> getDepartementData({required String idFaculte}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Departement.php"),
        body: {
          'App_name': "app",
          'token': "2022",
          "id": idFaculte
        }).then((response) {
      var data = json.decode(response.body);

      return data['donnees'] ?? [];
    }).catchError((onError) {});
  }

  static Future<List> getPromotionData({required String idDepartement}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_promotion.php"),
        body: {
          'App_name': "app",
          'token': "2022",
          "id": idDepartement
        }).then((response) {
      var data = json.decode(response.body);

      return data['donnees'] ?? [];
    }).catchError((onError) {});
  }

  static Future<List> getProvinceData() async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}Trans_liste_Province.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      return data['donnees'];
    }).catchError((onError) {});
  }

  static Future<List> getVilleData({required String idProvince}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}listeVille.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      // return data['donnees'];
      return data['donnees']
          .where((e) => e['provinceID'] == idProvince)
          .toList();
    }).catchError((onError) {});
  }

  static Future<List> getCommuneData({required String idVille}) async {
    return await http.post(
        Uri.parse("${StringFormat.stateInfoUrl}listeCommune.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

      // return data['donnees'];
      return data['donnees'].where((e) => e['IDVILLE'] == idVille).toList();
    }).catchError((onError) {});
  }
}
