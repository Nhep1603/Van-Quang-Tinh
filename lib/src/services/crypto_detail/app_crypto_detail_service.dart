import 'package:http/http.dart' as http;

import './crypto_detail_service.dart';

class AppCryptoDetailService extends CryptoDetailService {
  AppCryptoDetailService(http.Client client) : super(client);
}