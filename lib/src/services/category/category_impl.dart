import 'dart:convert';

import 'package:http/http.dart' as http;

import './category_service.dart';
import '../../config/app_config.dart';
import '../../config/app_constants.dart';
import '../../models/category.dart';

class CategoryImpl extends CategoryService {
  CategoryImpl(http.Client client) : super(client);

  @override
  Future<List<Category>> fetchCategory() async {
    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(AppConstants.hostName),
      path: AppConfig.instance.getValue(AppConstants.cryptoPath) +
          AppConfig.instance.getValue(AppConstants.categoryPath),
    );

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      Iterable responseList = json.decode(response.body);
      var categories = List<Category>.from(
          responseList.map((model) => Category.fromJson(model)));

      return categories;
    } else {
      throw Exception('Failed to load category list');
    }
  }
}
