import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_impl.dart';

import './blocs/category/category_bloc.dart';
import './config/routes.dart';
import './screens/home_screen.dart';
import './services/category/app_category_service.dart';
import 'blocs/search/search_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
              create: (context) => CategoryBloc(
                service: AppCategoryService(httpClient),
              ),
            ),
            BlocProvider(
              create: (context) => SearchBloc(
                service: CryptoCurrencyImpl(httpClient),
              ),
            ),
            BlocProvider(
              create: (context) => CryptoDetailBloc(
              ),
            ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: buildRoutes(),
        home: const HomeScreen(),
      ),
    );
  }
}
