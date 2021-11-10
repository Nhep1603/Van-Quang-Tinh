import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.icondata,
      required this.symbolImagePath,
      required this.titleAppBar,
      this.onPressed})
      : super(key: key);

  final IconData icondata;
  final String symbolImagePath;
  final String titleAppBar;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double toolbarHeight = 70.0;
    double backButtonHeight = toolbarHeight * .4;
    double backButtonAndSymbolImageSpacing = 50.0;
    double symbolImageWidth = 40.0;

    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          icondata,
          color: Colors.black,
          size: backButtonHeight,
        ),
        onPressed: onPressed,
        splashRadius: backButtonHeight / 1.5,
      ),
      actions: [
        SizedBox(
          width: backButtonAndSymbolImageSpacing,
        ),
        SizedBox(
          width: symbolImageWidth,
          child: Image.asset(
            symbolImagePath,
            scale: 2.2,
          ),
        ),
        Align(
          child: Text(
            titleAppBar,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.45,
                  color: Colors.black87.withOpacity(0.6),
                ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
