import 'package:http/http.dart' as http;

abstract class CryptoDetailService {
  final http.Client client;

  CryptoDetailService(this.client);
}
