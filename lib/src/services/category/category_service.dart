import 'package:http/http.dart' as http;

import '../../models/category.dart';

abstract class CategoryService {
  final http.Client client;

  CategoryService(this.client);

  Future<List<Category>>? fetchCategory();
}
