import 'package:flutter/material.dart';
import 'package:core/core.dart';

import '../../../../l10n/gen/l10n.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_state_view.dart';
import '../cubit/sample_cubit.dart';
import '../models/sample_model.dart';

class SampleView extends StatelessWidget {
  const SampleView({
    required this.status,
    required this.items,
    required this.environmentName,
    required this.onRefresh,
    required this.onCreate,
    super.key,
  });

  final SampleStatus status;
  final List<SampleItemModel> items;
  final String environmentName;
  final Future<void> Function() onRefresh;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.current;
    final isLoading = status == SampleStatus.loading;
    final isSubmitting = status == SampleStatus.submitting;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sampleModuleTitle),
        actions: [
          IconButton(
            tooltip: l10n.sampleRefresh,
            onPressed: isLoading ? null : onRefresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isSubmitting ? null : onCreate,
        icon: const Icon(Icons.add),
        label: Text(l10n.sampleCreate),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              sliver: SliverToBoxAdapter(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sampleModuleDescription,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.sampleModuleHint),
                      const SizedBox(height: 8),
                      Text(
                        l10n.apiEnvironment(environmentName),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading && items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: AppStateView(
                  title: l10n.sampleItemsTitle,
                  isLoading: true,
                ),
              )
            else if (status == SampleStatus.error && items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: AppStateView(
                  title: l10n.sampleLoadError,
                  actionLabel: l10n.retry,
                  onAction: onRefresh,
                ),
              )
            else if (items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: AppStateView(title: l10n.sampleEmpty),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                sliver: SliverList.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      _SampleItemCard(item: items[index]),
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SampleItemCard extends StatelessWidget {
  const _SampleItemCard({required this.item});

  final SampleItemModel item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name, style: Theme.of(context).textTheme.titleMedium),
          if (item.description != null) ...[
            const SizedBox(height: 6),
            Text(item.description!),
          ],
          if (item.createdAt != null) ...[
            const SizedBox(height: 10),
            Text(
              AppDateFormatter.format(item.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
