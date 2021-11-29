import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_constants.dart';
<<<<<<< HEAD
import './crypto_currency_service.dart';
import '../../models/crypto.dart';
=======
import '../../models/crypto.dart';
import './crypto_currency_service.dart';
>>>>>>> c11a5712528b53f639beed76fae82a5be6cc08c7

class CryptoCurrencyImpl extends CryptoCurrencyService {
  CryptoCurrencyImpl(http.Client client) : super(client);

  @override
<<<<<<< HEAD
  Future<List<Crypto>>? fetchAllCryptoCurrency() async {
    final queryParameters = {
      AppConfig.instance.getValue(AppConstants.currency):
          AppConstants.currencyOfMarket,
=======
  Future<List<Crypto>>? fetchCryptoCurrency(int page) async {
    final queryParameters = {
      AppConfig.instance.getValue(AppConstants.currency):
          AppConstants.currencyOfMarket,
      AppConfig.instance.getValue(AppConstants.perPage): AppConstants.limit,
      AppConfig.instance.getValue(AppConstants.page): '$page',
>>>>>>> c11a5712528b53f639beed76fae82a5be6cc08c7
    };

    final uri = Uri(
        scheme: 'https',
        host: AppConfig.instance.getValue(AppConstants.hostName),
<<<<<<< HEAD
        path: AppConfig.instance.getValue(AppConstants.cryptoPath) +
=======
        path: AppConfig.instance.getValue(AppConstants.cryptoCurrencyPath) +
>>>>>>> c11a5712528b53f639beed76fae82a5be6cc08c7
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
