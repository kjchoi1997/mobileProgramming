import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sillog/home/controller/user_controller.dart';

const baseUrl = 'https://sillog-production.herokuapp.com/';

class ApiClient {
  final userController = Get.find<UserController>();

  postApi(
      String api, Map<String, String> headers, Map<String, String> body) async {
    //post, body: map
    final url = Uri.parse('$baseUrl$api');
    try {
      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      return response;
    } catch (_) {}
  }

  postApi_dynamic(String api, Map<String, String> headers, dynamic body) async {
    //post, body: dynamic
    final url = Uri.parse('$baseUrl$api');
    try {
      http.Response response =
          await http.post(url, headers: headers, body: body);
      return response;
    } catch (_) {}
  }

  patchApi_dynamic(
      String api, Map<String, String> headers, dynamic body) async {
    //post, body: dynamic
    final url = Uri.parse('$baseUrl$api');
    try {
      http.Response response =
          await http.patch(url, headers: headers, body: body);
      return response;
    } catch (_) {}
  }

  getApi(String api, Map<String, String> headers) async {
    //get API
    final url = Uri.parse('$baseUrl$api');
    try {
      http.Response response = await http.get(url, headers: headers);
      return response;
    } catch (_) {}
  }

  deleteApi(String api, Map<String, String> headers) async {
    //delete API
    final url = Uri.parse('$baseUrl$api');
    try {
      http.Response response = await http.delete(url, headers: headers);
      return response;
    } catch (_) {}
  }
}
