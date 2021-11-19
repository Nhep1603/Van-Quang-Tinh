import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto_detail/crypto_detail_bloc.dart';
import '../blocs/crypto_detail/crypto_detail_event.dart';
import '../blocs/crypto_detail/crypto_detail_state.dart';
import '../enum/line_chart_enum.dart';
import '../constants/constants.dart' as constants;
import '../constants/line_chart_data.dart';
import '../utils/custom_number_format.dart';
import '../widgets/currency_conversion_text_field.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_crypto_price_line_chart.dart';

class CryptoDetailScreen extends StatelessWidget {
  const CryptoDetailScreen({Key? key}) : super(key: key);

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
    double sadlyEmojiImageRightPadding = 15.0;
    double smileEmojiImageLeftPadding = 15.0;
    double voteBarHeight = 20.0;

    context.read<CryptoDetailBloc>().add(CryptoDetailStarted());
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(constants.CryptoDetailScreen.toolbarHeight),
        child: CustomAppBar(
          icondata: Icons.arrow_back_ios_rounded,
          symbolImagePath: constants.CryptoDetailScreen.symbolImagePath,
          titleAppBar: constants.CryptoDetailScreen.titleAppBar,
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: curentPriceLeftPadding,
                ),
                Text(
                  '\$${CustomNumberFormat.customNumberFormatWithCommas(constants.CryptoDetailScreen.currentPrice)}',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 38.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                SizedBox(
                  width: currentPriceAndPriceChangePercentage24hSpacing,
                ),
                Text(
                  '${constants.CryptoDetailScreen.priceChangePercentage24h}%',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: constants.CryptoDetailScreen
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: CurrencyConverSionTextField(
                      labelText: constants.CryptoDetailScreen.bitcoinSymbol,
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
                  const Flexible(
                    child: CurrencyConverSionTextField(
                      labelText: constants.CryptoDetailScreen.usd,
                      isCrypto: false,
                      currentCryptoPrice:
                          constants.CryptoDetailScreen.currentPrice,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: currencyConversionAndChartSpacing,
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(right: lineChartRightPadding),
                  height: constants.CryptoDetailScreen.lineChartHeight,
                  child: BlocBuilder<CryptoDetailBloc, CryptoDetailState>(
                    builder: (context, state) {
                      if (state is CryptoDetailLoadSucess) {
                        if (state.lineChartType == LineChartType.chart7D) {
                          return CustomCryptoPriceLineChart(
                            prices: prices7D,
                            lineChartType: LineChartType.chart7D,
                          );
                        }
                      }

                      return CustomCryptoPriceLineChart(
                        prices: prices24H,
                        lineChartType: LineChartType.chart24H,
                      );
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
                horizontal: textButtonsSectionHorizontalPaddingOfLineChart,
              ),
              child: BlocBuilder<CryptoDetailBloc, CryptoDetailState>(
                builder: (context, state) {
                  if (state is CryptoDetailLoadSucess) {
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () => context.read<CryptoDetailBloc>().add(
                              const CryptoDetailLoadedChart(
                                  lineChartType: LineChartType.chart24H)),
                          child: const Text(
                              constants.CryptoDetailScreen.button24Hours),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                state.lineChartType == LineChartType.chart24H
                                    ? Colors.lightGreen.shade500
                                    : Colors.transparent,
                            primary:
                                state.lineChartType == LineChartType.chart24H
                                    ? Colors.white70
                                    : Colors.grey.shade700,
                            minimumSize: const Size(10.0, 10.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.read<CryptoDetailBloc>().add(
                              const CryptoDetailLoadedChart(
                                  lineChartType: LineChartType.chart7D)),
                          child: const Text(
                              constants.CryptoDetailScreen.button7Days),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                state.lineChartType == LineChartType.chart7D
                                    ? Colors.lightGreen.shade500
                                    : Colors.transparent,
                            primary:
                                state.lineChartType == LineChartType.chart7D
                                    ? Colors.white70
                                    : Colors.grey.shade700,
                            minimumSize: const Size(10.0, 10.0),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          constants.CryptoDetailScreen.lineChartName,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
            BlocBuilder<CryptoDetailBloc, CryptoDetailState>(
              builder: (context, state) {
                if (state is CryptoDetailLoadSucess) {
                  if (state.isVoted) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(voteBarSectionPadding),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: sadlyEmojiImageRightPadding),
                                child: Image.asset(
                                  constants
                                      .CryptoDetailScreen.sadlyEmojiImagePath,
                                  height: constants
                                      .CryptoDetailScreen.emojiSmallImageHeight,
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
                                  constants
                                      .CryptoDetailScreen.smileEmojiImagePath,
                                  height: constants
                                      .CryptoDetailScreen.emojiSmallImageHeight,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          constants.CryptoDetailScreen.thanksForYourVote,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.lightGreen.shade500,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    );
                  }
                }

                return Column(
                  children: [
                    Text(
                      constants.CryptoDetailScreen.cryptoTitleVote,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
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
                              .read<CryptoDetailBloc>()
                              .add(CryptoDetailVoted()),
                          child: Image.asset(
                            constants.CryptoDetailScreen.sadlyEmojiImagePath,
                            height: constants
                                .CryptoDetailScreen.emojiLargeImageHeight,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context
                              .read<CryptoDetailBloc>()
                              .add(CryptoDetailVoted()),
                          child: Image.asset(
                            constants.CryptoDetailScreen.smileEmojiImagePath,
                            height: constants
                                .CryptoDetailScreen.emojiLargeImageHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
