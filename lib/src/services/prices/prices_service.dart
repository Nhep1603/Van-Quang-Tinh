import 'package:http/http.dart' as http;

import '../../models/prices.dart';

abstract class PricesService {
  final http.Client client;

  PricesService(this.client);

  Future<Prices>? fetchPrices(String cryptoId, int days);

}