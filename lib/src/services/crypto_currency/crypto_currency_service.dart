import 'package:http/http.dart' as http;

import '../../models/crypto.dart';

abstract class CryptoCurrencyService {
  final http.Client client;

  CryptoCurrencyService(this.client);

  Future<List<Crypto>>? fetchAllCryptoCurrency();
  Future<List<Crypto>>? fetchCryptoCurrency(int page);
}
