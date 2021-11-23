import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:van_quang_tinh/src/services/crypto_currency_service/crypto_currency_impl.dart';

import './config/routes.dart';
import './screens/home_screen.dart';
import './blocs/crypto_detail/crypto_detail_bloc.dart';
import './blocs/crypto_currency/bloc/crypto_currency_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CryptoDetailBloc(),
        ),
        BlocProvider(
          create: (context) =>
              CryptoCurrencyBloc(service: CryptoCurrencyImpl(httpClient)),
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
