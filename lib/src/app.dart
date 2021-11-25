import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import './blocs/crypto_detail/crypto_detail_bloc.dart';
import './blocs/category/category_bloc.dart';
import './blocs/search/search_bloc.dart';
import './config/routes.dart';
import './services/category/impl_category_service.dart';
import './services/crypto_currency/crypto_currency_impl.dart';
import './screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
              create: (context) => CategoryBloc(
                service: ImplCategoryService(httpClient),
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
