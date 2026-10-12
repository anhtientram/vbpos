import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domains/entities/sample/sample_entities.dart';
import '../../../../domains/usecases/sample/create_sample_item_usecase.dart';
import '../../../../domains/usecases/sample/get_sample_items_usecase.dart';
import '../models/sample_model.dart';
import '../models/sample_presentations_mapper.dart';

part 'sample_state.dart';

class SampleCubit extends Cubit<SampleState> {
  SampleCubit({
    required GetSampleItemsUseCase getSampleItems,
    required CreateSampleItemUseCase createSampleItem,
  }) : _getSampleItems = getSampleItems,
       _createSampleItem = createSampleItem,
       super(const SampleState());

  final GetSampleItemsUseCase _getSampleItems;
  final CreateSampleItemUseCase _createSampleItem;

  Future<void> load() async {
    emit(state.copyWith(status: SampleStatus.loading, action: SampleAction.load));
    final result = await _getSampleItems();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SampleStatus.error,
          action: SampleAction.load,
          errorMessage: failure.message,
        ),
      ),
      (items) => emit(
        state.copyWith(
          status: SampleStatus.success,
          action: SampleAction.load,
          items: items.map(SamplePresentationsMapper.toItemModel).toList(),
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> create(CreateSampleItemParams params) async {
    emit(
      state.copyWith(
        status: SampleStatus.submitting,
        action: SampleAction.create,
        errorMessage: null,
      ),
    );
    final result = await _createSampleItem(params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SampleStatus.error,
          action: SampleAction.create,
          errorMessage: failure.message,
        ),
      ),
      (item) => emit(
        state.copyWith(
          status: SampleStatus.success,
          action: SampleAction.create,
          items: [
            SamplePresentationsMapper.toItemModel(item),
            ...state.items,
          ],
          errorMessage: null,
        ),
      ),
    );
  }
}
