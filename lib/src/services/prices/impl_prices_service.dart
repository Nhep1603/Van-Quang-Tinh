import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/app_constants.dart';
import '../../models/prices.dart';
import './prices_service.dart';

class ImplPricesService extends PricesService {
  ImplPricesService(http.Client client) : super(client);

  @override
  Future<Prices> fetchPrices(String cryptoId, int days) async {
    Map<String, dynamic> queryParameters = {
      AppConfig.instance.getValue(AppConstants.currency):
          AppConstants.currencyOfMarket,
      AppConfig.instance.getValue(AppConstants.days): days.toString(),
    };

    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(AppConstants.hostName),
      path: AppConfig.instance.getValue(AppConstants.cryptoPath) +
          '/$cryptoId' +
          AppConfig.instance.getValue(AppConstants.marketChartPath),
      queryParameters: queryParameters,
    );

    final response = await client.get(uri);
    
    if (response.statusCode == 200) {
      var prices = Prices.fromJson(json.decode(response.body));
      return prices;
    } else {
      throw Exception('Failed to load bitcoin');
    }
  }
}