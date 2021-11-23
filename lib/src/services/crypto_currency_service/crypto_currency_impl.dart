import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:van_quang_tinh/src/config/app_config.dart';
import 'package:van_quang_tinh/src/config/app_constants.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'crypto_currency_service.dart';

class CryptoCurrencyImpl extends CryptoCurrencyService {
  CryptoCurrencyImpl(http.Client client) : super(client);

  @override
  Future<List<Crypto>>? fetchAllCryptoCurrency() async {
    final queryParameters = {
      AppConfig.instance.getValue(AppConstants.currency):
          AppConstants.currencyOfMarket,
    };

    final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConstants.hostName),
        path: AppConfig.instance.getValue(AppConstants.cryptoCurrencyPath) +
            AppConfig.instance.getValue(AppConstants.marketPath),
        queryParameters: queryParameters);

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        Iterable responseList = json.decode(response.body);

        var cryptos = List<Crypto>.from(
            responseList.map((model) => Crypto.fromJson(model)));

        return cryptos;
      } else {
        throw Exception('Failed to load crypto list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Crypto>>? fetchCryptoCurrency(int page) async {
    final queryParameters = {
      AppConfig.instance.getValue(AppConstants.currency):
          AppConstants.currencyOfMarket,
      AppConfig.instance.getValue(AppConstants.perPage): AppConstants.limit,
      AppConfig.instance.getValue(AppConstants.page): '$page',
    };

    final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConstants.hostName),
        path: AppConfig.instance.getValue(AppConstants.cryptoCurrencyPath) +
            AppConfig.instance.getValue(AppConstants.marketPath),
        queryParameters: queryParameters);

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        Iterable responseList = json.decode(response.body);

        var cryptos = List<Crypto>.from(
            responseList.map((model) => Crypto.fromJson(model)));

        return cryptos;
      } else {
        throw Exception('Failed to load crypto list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
