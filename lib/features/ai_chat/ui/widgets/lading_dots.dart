import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class LoadingDots extends StatelessWidget {
  const LoadingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(16),
            ),
            color: Colors.grey,
          ),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 6),
          child: Center(
            child: JumpingDots(
              color: Colors.black,
              radius: 3,
              numberOfDots: 3,
              animationDuration: const Duration(milliseconds: 300),
              verticalOffset: -10,
            ),
          ),
        ),
      ],
    );
  }
}
