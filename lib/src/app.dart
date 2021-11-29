import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import './blocs/crypto_currency/crypto_currency_bloc.dart';
import './blocs/crypto_detail/crypto_detail_bloc.dart';
import './config/routes.dart';
import './screens/home_screen.dart';
import './services/crypto_currency/crypto_currency_impl.dart';
import './blocs/crypto_detail/crypto_detail_bloc.dart';
import './blocs/crypto_detail_function/crypto_detail_function_bloc.dart';
import './services/crypto_detail/impl_crypto_detail_service.dart';
import './services/prices/impl_prices_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CryptoDetailBloc(
            cryptoDetailService: ImplCryptoDetailService(httpClient),
            pricesService: ImplPricesService(httpClient),
          ),
        ),
        BlocProvider(
          create: (context) => CryptoDetailFunctionBloc(),
        ),
        BlocProvider(
          create: (context) =>
              CryptoCurrencyBloc(service: CryptoCurrencyImpl(httpClient)),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        home: HomeScreen(),
      ),
    );
  }
}
