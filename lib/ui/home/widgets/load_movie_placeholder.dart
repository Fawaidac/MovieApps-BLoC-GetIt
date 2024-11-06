import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadMoviePlaceholder extends StatelessWidget {
  const LoadMoviePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardLoading(
            height: 170,
            width: 120,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 5),
          CardLoading(
            height: 10,
            width: 120,
            borderRadius: BorderRadius.circular(5),
            margin: const EdgeInsets.only(bottom: 3),
          ),
          CardLoading(
            margin: const EdgeInsets.only(bottom: 3),
            height: 10,
            width: 80,
            borderRadius: BorderRadius.circular(5),
          ),
          CardLoading(
              height: 10, width: 100, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
  }
}
