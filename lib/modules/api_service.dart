import 'dart:convert';

import 'package:diamond/modules/user_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<UserData> fetchUserData(String userId) async {
    final Map<String, dynamic> requestData = {'user_id': userId};
    final url = Uri.parse('https://diamond-7n50.onrender.com/me');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;

      try {
        final meData = jsonDecode(responseBody)["me"];
        final userData = UserData(
          username: meData["name"],
          email: meData["email"],
          contact: meData["contact"],
          country: meData["country"],
          address: meData["address"],
          gender: meData["gender"],
          image: meData["image"],
          referralCode: meData["referral_code"],
          userId: meData["user_id"],
        );
        return userData;
      } catch (e) {
        print("Error decoding JSON: $e");
        throw Exception("Error decoding JSON");
      }
    } else {
      print("Request failed with status: ${response.statusCode}");
      throw Exception("Request failed with status: ${response.statusCode}");
    }
  }
}
