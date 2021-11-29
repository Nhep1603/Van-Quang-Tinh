import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto_detail/crypto_detail_bloc.dart';
import '../blocs/crypto_detail/crypto_detail_event.dart';
import '../blocs/crypto_detail/crypto_detail_state.dart';
import '../blocs/crypto_detail_function/crypto_detail_function_bloc.dart';
import '../blocs/crypto_detail_function/crypto_detail_function_event.dart';
import '../blocs/crypto_detail_function/crypto_detail_function_state.dart';
import '../constants/constants.dart' as constants;
import '../enum/line_chart_enum.dart';
import '../utils/custom_number_format.dart';
import '../widgets/currency_conversion_text_field.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_crypto_price_line_chart.dart';

class CryptoDetailScreen extends StatefulWidget {
  final String cryptoId;

  const CryptoDetailScreen(this.cryptoId, {Key? key}) : super(key: key);

  @override
  State<CryptoDetailScreen> createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
  final cryptoTextFieldController = TextEditingController();
  final usdTextFieldController = TextEditingController();

  @override
  void dispose() {
    cryptoTextFieldController.dispose();
    usdTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double curentPriceLeftPadding = 20.0;
    double currentPriceAndPriceChangePercentage24hSpacing = 5.0;
    double currentPriceAndCurrencyConversionSpacing = 40.0;
    double currencyConversionHorizontalPadding = 25.0;
    double syncIconHorizontalPadding = 10.0;
    double currencyConversionAndChartSpacing = 70.0;
    double lineChartAndCryptoVoteSpacing = 40.0;
    double lineChartRightPadding = 35.0;
    double logoImageBottomPadding = 50.0;
    double logoImageRightPadding = 10.0;
    double cryptoVoteTitleAndEmojiImagesSpacing = 10.0;
    double logoImageHeight = 25.0;
    double textButtonsSectionHorizontalPaddingOfLineChart = 30.0;
    double voteBarSectionPadding = 20.0;
    double sadEmojiImageRightPadding = 15.0;
    double smileEmojiImageLeftPadding = 15.0;
    double voteBarHeight = 20.0;

    context
        .read<CryptoDetailBloc>()
        .add(CryptoDetailStarted(cryptoId: widget.cryptoId));

    return BlocBuilder<CryptoDetailBloc, CryptoDetailState>(
      builder: (context, state) {
        if (state is CryptoDetailLoadInProgress) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is CryptoDetailLoadFailure) {
          return Scaffold(
            body: Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: Text(state.errorMessage!),
            ),
          );
        }
        if (state is CryptoDetailLoadSuccess) {
          context
              .read<CryptoDetailFunctionBloc>()
              .add(CryptoDetailFunctionStarted(
                cryptoDetail: state.cryptoDetail,
                prices24H: state.prices24H,
                prices7D: state.prices7D,
              ));
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(
                  constants.CryptoDetailScreen.toolbarHeight),
              child: CustomAppBar(
                icondata: Icons.arrow_back_ios_rounded,
                symbolImagePath: state.cryptoDetail.image.small,
                titleAppBar: state.cryptoDetail.name,
                onPressed: () => Navigator.maybePop(context),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                usdTextFieldController.text = '';
                cryptoTextFieldController.text = '';
                context
                    .read<CryptoDetailBloc>()
                    .add(CryptoDetailStarted(cryptoId: widget.cryptoId));
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: curentPriceLeftPadding,
                        ),
                        Text(
                          '\$${CustomNumberFormat.customNumberFormatWithCommas(state.cryptoDetail.marketData.currentPrice.usdPrice)}',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 38.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        SizedBox(
                          width: currentPriceAndPriceChangePercentage24hSpacing,
                        ),
                        Text(
                          '${CustomNumberFormat.customNumberFormatWithOneDecimalPlace(state.cryptoDetail.marketData.priceChangePercentage24h)}%',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: state.cryptoDetail.marketData
                                                .priceChangePercentage24h <
                                            0
                                        ? Colors.red.shade300
                                        : Colors.lightGreen.shade300,
                                    fontWeight: FontWeight.w500,
                                  ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: currentPriceAndCurrencyConversionSpacing,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: currencyConversionHorizontalPadding),
                      child: BlocBuilder<CryptoDetailFunctionBloc,
                          CryptoDetailFunctionState>(
                        buildWhen: (previous, current) =>
                            current is CryptoDetailFunctionLoadSuccess ||
                            current
                                is CryptoDetailFunctionLoadCurrencyConversionSectionSuccess,
                        builder: (context, state) {
                          if (state is CryptoDetailFunctionLoadSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: CurrencyConverSionTextField(
                                    controller: cryptoTextFieldController,
                                    labelText:
                                        state.cryptoDetail.symbol.toUpperCase(),
                                    hintext: CustomNumberFormat
                                        .customNumberFormatWithoutCommas(
                                            state.cryptoPriceTextField),
                                    onChanged: (value) {
                                      usdTextFieldController.text = '';
                                      context.read<CryptoDetailFunctionBloc>().add(
                                          CryptoDetailFunctionChangedCryptoTextField(
                                              cryptoTextFieldValue:
                                                  double.tryParse(value) ??
                                                      1.0));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: syncIconHorizontalPadding),
                                  child: Icon(
                                    Icons.sync_alt,
                                    color: Colors.lightGreen.shade300,
                                  ),
                                ),
                                Flexible(
                                  child: CurrencyConverSionTextField(
                                    controller: usdTextFieldController,
                                    labelText: constants.CryptoDetailScreen.usd,
                                    isCrypto: false,
                                    hintext: CustomNumberFormat
                                        .customNumberFormatWithoutCommas(
                                            state.usdPriceTextField),
                                    onChanged: (value) {
                                      cryptoTextFieldController.text = '';
                                      context.read<CryptoDetailFunctionBloc>().add(
                                          CryptoDetailFunctionChangedUsdTextField(
                                              usdTextFieldValue:
                                                  double.tryParse(value) ??
                                                      state
                                                          .cryptoDetail
                                                          .marketData
                                                          .currentPrice
                                                          .usdPrice
                                                          .toDouble()));
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                          if (state
                              is CryptoDetailFunctionLoadCurrencyConversionSectionSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: CurrencyConverSionTextField(
                                    controller: cryptoTextFieldController,
                                    labelText:
                                        state.cryptoDetail.symbol.toUpperCase(),
                                    hintext: CustomNumberFormat
                                        .customNumberFormatWithoutCommas(
                                            state.cryptoPriceTextField),
                                    onChanged: (value) {
                                      usdTextFieldController.text = '';
                                      context.read<CryptoDetailFunctionBloc>().add(
                                          CryptoDetailFunctionChangedCryptoTextField(
                                              cryptoTextFieldValue:
                                                  double.tryParse(value) ??
                                                      1.0));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: syncIconHorizontalPadding),
                                  child: Icon(
                                    Icons.sync_alt,
                                    color: Colors.lightGreen.shade300,
                                  ),
                                ),
                                Flexible(
                                  child: CurrencyConverSionTextField(
                                    controller: usdTextFieldController,
                                    labelText: constants.CryptoDetailScreen.usd,
                                    isCrypto: false,
                                    hintext: CustomNumberFormat
                                        .customNumberFormatWithoutCommas(
                                            state.usdPriceTextField),
                                    onChanged: (value) {
                                      cryptoTextFieldController.text = '';
                                      context.read<CryptoDetailFunctionBloc>().add(
                                          CryptoDetailFunctionChangedUsdTextField(
                                              usdTextFieldValue:
                                                  double.tryParse(value) ??
                                                      state
                                                          .cryptoDetail
                                                          .marketData
                                                          .currentPrice
                                                          .usdPrice
                                                          .toDouble()));
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    SizedBox(
                      height: currencyConversionAndChartSpacing,
                    ),
                    Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(right: lineChartRightPadding),
                          height: constants.CryptoDetailScreen.lineChartHeight,
                          child: BlocBuilder<CryptoDetailFunctionBloc,
                              CryptoDetailFunctionState>(
                            buildWhen: (previous, current) =>
                                current is CryptoDetailFunctionLoadSuccess ||
                                current is CryptoDetailFunctionLoadChartSuccess,
                            builder: (context, state) {
                              if (state is CryptoDetailFunctionLoadSuccess) {
                                if (state.lineChartType ==
                                    LineChartType.chart7D) {
                                  return CustomCryptoPriceLineChart(
                                    prices: state.prices7D,
                                    lineChartType: LineChartType.chart7D,
                                  );
                                }
                                if (state.lineChartType ==
                                    LineChartType.chart24H) {
                                  return CustomCryptoPriceLineChart(
                                    prices: state.prices24H,
                                    lineChartType: LineChartType.chart24H,
                                  );
                                }
                              }
                              if (state
                                  is CryptoDetailFunctionLoadChartSuccess) {
                                if (state.lineChartType ==
                                    LineChartType.chart7D) {
                                  return CustomCryptoPriceLineChart(
                                    prices: state.prices7D,
                                    lineChartType: LineChartType.chart7D,
                                  );
                                }
                                if (state.lineChartType ==
                                    LineChartType.chart24H) {
                                  return CustomCryptoPriceLineChart(
                                    prices: state.prices24H,
                                    lineChartType: LineChartType.chart24H,
                                  );
                                }
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        Positioned(
                          bottom: logoImageBottomPadding,
                          right: logoImageRightPadding,
                          height: logoImageHeight,
                          child: Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              constants.CryptoDetailScreen.logoImagePath,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            textButtonsSectionHorizontalPaddingOfLineChart,
                      ),
                      child: BlocBuilder<CryptoDetailFunctionBloc,
                          CryptoDetailFunctionState>(
                        buildWhen: (previous, current) =>
                            current is CryptoDetailFunctionLoadSuccess ||
                            current is CryptoDetailFunctionLoadChartSuccess,
                        builder: (context, state) {
                          if (state is CryptoDetailFunctionLoadSuccess) {
                            return Row(
                              children: [
                                TextButton(
                                  onPressed: () => context
                                      .read<CryptoDetailFunctionBloc>()
                                      .add(
                                          const CryptoDetailFunctionLoadedChart(
                                              lineChartType:
                                                  LineChartType.chart24H)),
                                  child: const Text(constants
                                      .CryptoDetailScreen.button24Hours),
                                  style: TextButton.styleFrom(
                                    backgroundColor: state.lineChartType ==
                                            LineChartType.chart24H
                                        ? Colors.lightGreen.shade500
                                        : Colors.transparent,
                                    primary: state.lineChartType ==
                                            LineChartType.chart24H
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                    minimumSize: const Size(10.0, 10.0),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => context
                                      .read<CryptoDetailFunctionBloc>()
                                      .add(
                                          const CryptoDetailFunctionLoadedChart(
                                              lineChartType:
                                                  LineChartType.chart7D)),
                                  child: const Text(
                                      constants.CryptoDetailScreen.button7Days),
                                  style: TextButton.styleFrom(
                                    backgroundColor: state.lineChartType ==
                                            LineChartType.chart7D
                                        ? Colors.lightGreen.shade500
                                        : Colors.transparent,
                                    primary: state.lineChartType ==
                                            LineChartType.chart7D
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                    minimumSize: const Size(10.0, 10.0),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  constants.CryptoDetailScreen.lineChartName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey.shade700,
                                        letterSpacing: 0.3,
                                      ),
                                ),
                              ],
                            );
                          }
                          if (state is CryptoDetailFunctionLoadChartSuccess) {
                            return Row(
                              children: [
                                TextButton(
                                  onPressed: () => context
                                      .read<CryptoDetailFunctionBloc>()
                                      .add(
                                          const CryptoDetailFunctionLoadedChart(
                                              lineChartType:
                                                  LineChartType.chart24H)),
                                  child: const Text(constants
                                      .CryptoDetailScreen.button24Hours),
                                  style: TextButton.styleFrom(
                                    backgroundColor: state.lineChartType ==
                                            LineChartType.chart24H
                                        ? Colors.lightGreen.shade500
                                        : Colors.transparent,
                                    primary: state.lineChartType ==
                                            LineChartType.chart24H
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                    minimumSize: const Size(10.0, 10.0),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => context
                                      .read<CryptoDetailFunctionBloc>()
                                      .add(
                                          const CryptoDetailFunctionLoadedChart(
                                              lineChartType:
                                                  LineChartType.chart7D)),
                                  child: const Text(
                                      constants.CryptoDetailScreen.button7Days),
                                  style: TextButton.styleFrom(
                                    backgroundColor: state.lineChartType ==
                                            LineChartType.chart7D
                                        ? Colors.lightGreen.shade500
                                        : Colors.transparent,
                                    primary: state.lineChartType ==
                                            LineChartType.chart7D
                                        ? Colors.white70
                                        : Colors.grey.shade700,
                                    minimumSize: const Size(10.0, 10.0),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  constants.CryptoDetailScreen.lineChartName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey.shade700,
                                        letterSpacing: 0.3,
                                      ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    SizedBox(
                      height: lineChartAndCryptoVoteSpacing,
                    ),
                    BlocBuilder<CryptoDetailFunctionBloc,
                        CryptoDetailFunctionState>(
                      buildWhen: (previous, current) =>
                          current is CryptoDetailFunctionLoadSuccess ||
                          current
                              is CryptoDetailFunctionLoadVotedSectionSuccess,
                      builder: (context, state) {
                        if (state
                            is CryptoDetailFunctionLoadVotedSectionSuccess) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(voteBarSectionPadding),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: sadEmojiImageRightPadding),
                                      child: Image.asset(
                                        constants.CryptoDetailScreen
                                            .sadEmojiImagePath,
                                        height: constants.CryptoDetailScreen
                                            .emojiSmallImageHeight,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        height: voteBarHeight,
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade600,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5.0),
                                            bottomLeft: Radius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        height: voteBarHeight,
                                        decoration: BoxDecoration(
                                          color: Colors.lightGreen.shade500,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(5.0),
                                            bottomRight: Radius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: smileEmojiImageLeftPadding),
                                      child: Image.asset(
                                        constants.CryptoDetailScreen
                                            .smileEmojiImagePath,
                                        height: constants.CryptoDetailScreen
                                            .emojiSmallImageHeight,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                constants.CryptoDetailScreen.thanksForYourVote,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.lightGreen.shade500,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          );
                        }
                        if (state is CryptoDetailFunctionLoadSuccess) {
                          return Column(
                            children: [
                              Text(
                                constants.CryptoDetailScreen.cryptoTitleVote,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                      color: Colors.grey.shade700,
                                    ),
                              ),
                              SizedBox(
                                height: cryptoVoteTitleAndEmojiImagesSpacing,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () => context
                                        .read<CryptoDetailFunctionBloc>()
                                        .add(CryptoDetailFunctionVoted()),
                                    child: Image.asset(
                                      constants
                                          .CryptoDetailScreen.sadEmojiImagePath,
                                      height: constants.CryptoDetailScreen
                                          .emojiLargeImageHeight,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => context
                                        .read<CryptoDetailFunctionBloc>()
                                        .add(CryptoDetailFunctionVoted()),
                                    child: Image.asset(
                                      constants.CryptoDetailScreen
                                          .smileEmojiImagePath,
                                      height: constants.CryptoDetailScreen
                                          .emojiLargeImageHeight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    Container(
                      height: 100,
                      color: Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container(
          color: Colors.orange,
        );
      },
    );
  }
}
