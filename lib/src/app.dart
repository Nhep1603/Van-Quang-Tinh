import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import './blocs/crypto_currency/crypto_currency_bloc.dart';
import './blocs/crypto_detail/crypto_detail_bloc.dart';
import './config/routes.dart';
import './screens/home_screen.dart';
import './services/crypto_currency/crypto_currency_impl.dart';



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
