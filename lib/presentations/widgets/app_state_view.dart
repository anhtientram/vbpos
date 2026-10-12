import 'package:flutter/material.dart';

import 'app_button.dart';

class AppStateView extends StatelessWidget {
  const AppStateView({
    required this.title,
    this.description,
    this.isLoading = false,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? description;
  final bool isLoading;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading) const CircularProgressIndicator(),
            if (isLoading) const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(description!, textAlign: TextAlign.center),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
