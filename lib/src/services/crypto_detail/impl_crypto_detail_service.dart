import 'package:http/http.dart' as http;

import './crypto_detail_service.dart';

class ImplCryptoDetailService extends CryptoDetailService {
  ImplCryptoDetailService(http.Client client) : super(client);
}