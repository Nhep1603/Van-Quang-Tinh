import 'package:http/http.dart' as http;

import '../../models/crypto_detail.dart';

abstract class CryptoDetailService {
  final http.Client client;

  CryptoDetailService(this.client);

  Future<CryptoDetail>? fetchCryptoDetail(String cryptoId);
}
