import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_constants.dart';
import '../../models/crypto_detail.dart';
import './crypto_detail_service.dart';

class ImplCryptoDetailService extends CryptoDetailService {
  ImplCryptoDetailService(http.Client client) : super(client);

  @override
  Future<CryptoDetail> fetchCryptoDetail(String cryptoId) async {
    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(AppConstants.hostName),
      path: AppConfig.instance.getValue(AppConstants.cryptoPath) + '/$cryptoId',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      var crypto = CryptoDetail.fromJson(json.decode(response.body));
      return crypto;
    } else {
      throw Exception('Failed to load bitcoin');
    }
  }
}