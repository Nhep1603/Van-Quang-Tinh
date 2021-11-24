import 'package:flutter/material.dart';

class LoadFailure extends StatelessWidget {
  final VoidCallback reload;
  const LoadFailure({Key? key, required this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cannot access data',
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 17),
          ),
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  primary: Colors.green),
              onPressed: () async {
                reload();
              },
              child: const Text('Try again'))
        ],
      ),
    );
  }
}
