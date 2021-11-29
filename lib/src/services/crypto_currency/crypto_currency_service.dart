import 'package:http/http.dart' as http;

import '../../models/crypto.dart';

abstract class CryptoCurrencyService {
  final http.Client client;

  CryptoCurrencyService(this.client);

<<<<<<< HEAD
  Future<List<Crypto>>? fetchAllCryptoCurrency();
=======
  Future<List<Crypto>>? fetchCryptoCurrency(int page);
>>>>>>> c11a5712528b53f639beed76fae82a5be6cc08c7
}
