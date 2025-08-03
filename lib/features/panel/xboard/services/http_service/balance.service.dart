import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hiddify/features/panel/xboard/services/http_service/http_service.dart';

class BalanceService {
  final HttpService _httpService = HttpService();

  // 划转佣金到余额的方法
  Future<bool> transferCommission(
    String accessToken,
    int transferAmount,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${_httpService.apiUrl}/transfer'),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {'amount': transferAmount.toString()},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['success'] as bool? ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
