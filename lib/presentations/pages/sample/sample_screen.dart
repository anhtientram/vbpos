import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';

import '../../../core/helpers/snackbar_helper.dart';
import '../../../l10n/gen/l10n.dart';
import '../../../domains/entities/sample/sample_entities.dart';
import '../../../domains/usecases/sample/create_sample_item_usecase.dart';
import '../../../domains/usecases/sample/get_sample_items_usecase.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import 'components/sample_view.dart';
import 'cubit/sample_cubit.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({
    required this.getSampleItems,
    required this.createSampleItem,
    required this.environmentName,
    super.key,
  });

  final GetSampleItemsUseCase getSampleItems;
  final CreateSampleItemUseCase createSampleItem;
  final String environmentName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SampleCubit(
        getSampleItems: getSampleItems,
        createSampleItem: createSampleItem,
      )..load(),
      child: const _SampleScreenBody(),
    );
  }
}

class _SampleScreenBody extends StatelessWidget {
  const _SampleScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SampleCubit, SampleState>(
      listener: (context, state) {
        final l10n = AppLocalization.current;
        if (state.status == SampleStatus.error) {
          SnackBarHelper.error(
            context,
            message:
                state.errorMessage ??
                (state.action == SampleAction.create
                    ? l10n.sampleCreateError
                    : l10n.sampleLoadError),
          );
        }
        if (state.status == SampleStatus.success &&
            state.action == SampleAction.create) {
          SnackBarHelper.success(context, message: l10n.sampleCreated);
        }
      },
      builder: (context, state) {
        final dependencies = context
            .findAncestorWidgetOfExactType<SampleScreen>();
        return SampleView(
          status: state.status,
          items: state.items,
          environmentName: dependencies?.environmentName ?? '',
          onRefresh: context.read<SampleCubit>().load,
          onCreate: () => _showCreateDialog(context),
        );
      },
    );
  }

  Future<void> _showCreateDialog(BuildContext context) async {
    final params = await showDialog<CreateSampleItemParams>(
      context: context,
      builder: (_) => const _CreateSampleDialog(),
    );
    if (params == null || !context.mounted) return;
    await context.read<SampleCubit>().create(params);
  }
}

class _CreateSampleDialog extends StatefulWidget {
  const _CreateSampleDialog();

  @override
  State<_CreateSampleDialog> createState() => _CreateSampleDialogState();
}

class _CreateSampleDialogState extends State<_CreateSampleDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _validationMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.current;
    return AlertDialog(
      title: Text(l10n.sampleCreate),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: _nameController,
              label: l10n.sampleItemName,
              hint: l10n.sampleItemNameHint,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _descriptionController,
              label: l10n.sampleItemDescription,
              hint: l10n.sampleItemDescriptionHint,
              maxLines: 3,
            ),
            if (_validationMessage != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _validationMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.sampleCancel),
        ),
        AppButton(label: l10n.sampleSave, onPressed: _submit),
      ],
    );
  }

  void _submit() {
    final l10n = AppLocalization.current;
    final name = AppStringUtils.nullIfBlank(_nameController.text);
    if (name == null) {
      setState(() => _validationMessage = l10n.sampleRequired);
      return;
    }
    Navigator.of(context).pop(
      CreateSampleItemParams(
        name: name,
        description: AppStringUtils.nullIfBlank(_descriptionController.text),
      ),
    );
  }
}
