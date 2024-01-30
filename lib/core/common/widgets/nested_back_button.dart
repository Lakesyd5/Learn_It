import 'package:flutter/material.dart';
import 'package:learn_it/core/extensions/context_extensions.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didpop) {
        try {
          context.pop();
          didpop = false;
        } catch (_) {
          didpop = true;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (e) {
            Navigator.of(context).pop();
      
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
