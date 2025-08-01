// services/domain_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DomainService {
  static const String ossDomain =
      'http://oss.lie-kong.top/api/v1/download-shared-object/aHR0cDovLzEyNy4wLjAuMTo5MDAwLzExMTEvZG9tYWluLmpzb24_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1VU0M2RTJXTzdHWkhCMVlaVUowOSUyRjIwMjUwODAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDgwMVQxMjM3NDhaJlgtQW16LUV4cGlyZXM9NDMyMDAmWC1BbXotU2VjdXJpdHktVG9rZW49ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmhZMk5sYzNOTFpYa2lPaUpWVTBNMlJUSlhUemRIV2toQ01WbGFWVW93T1NJc0ltVjRjQ0k2TVRjMU5EQTVORGszTUN3aWNHRnlaVzUwSWpvaWMzVndaWEpoWkcxcGJpSjkuc3NMZXNHY0xQM01MTEtFLVhibV9kTlFvUktaVUx5cmVrN2JYMm0ycFZybVlZT2tmSTgxbEZVb1J4bGlWdXE2cWZPcWVVMy1rUUF0ZjNnYmtqVlJiUUEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JnZlcnNpb25JZD1udWxsJlgtQW16LVNpZ25hdHVyZT03N2UzNjAyOTY2Yjc4ZTlmMWQ2YWUzYTZlNGRhZjI3MTc1ZTk1NzNhMzRmYWY0MmU3MzFlZDBhMDMyMzA2ODlh';

// 从返回的 JSON 中挑选一个可以正常访问的域名
  static Future<String> fetchValidDomain() async {
    try {
      final response = await http
          .get(Uri.parse(ossDomain))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> websites =
            json.decode(response.body) as List<dynamic>;
        for (final website in websites) {
          final Map<String, dynamic> websiteMap =
              website as Map<String, dynamic>;
          final String domain = websiteMap['url'] as String;
          print(domain);
          if (await _checkDomainAccessibility(domain)) {
            if (kDebugMode) {
              print('Valid domain found: $domain');
            }
            return domain;
          }
        }
        throw Exception('No accessible domains found.');
      } else {
        throw Exception(
            'Failed to fetch websites.json: $ossDomain ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching valid domain: $ossDomain:  $e');
      }
      rethrow;
    }
  }

  static Future<bool> _checkDomainAccessibility(String domain) async {
    try {
      final response = await http
          .get(Uri.parse('$domain/api/v1/guest/comm/config'))
          .timeout(const Duration(seconds: 15));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
