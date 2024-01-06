import 'package:flutter/material.dart';
import 'package:learn_it/core/extensions/context_extensions.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
