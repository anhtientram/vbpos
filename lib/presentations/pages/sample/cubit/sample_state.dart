part of 'sample_cubit.dart';

enum SampleStatus { initial, loading, submitting, success, error }

enum SampleAction { none, load, create }

class SampleState {
  const SampleState({
    this.status = SampleStatus.initial,
    this.action = SampleAction.none,
    this.items = const [],
    this.errorMessage,
  });

  final SampleStatus status;
  final SampleAction action;
  final List<SampleItemModel> items;
  final String? errorMessage;

  SampleState copyWith({
    SampleStatus? status,
    SampleAction? action,
    List<SampleItemModel>? items,
    String? errorMessage,
  }) {
    return SampleState(
      status: status ?? this.status,
      action: action ?? this.action,
      items: items ?? this.items,
      errorMessage: errorMessage,
    );
  }
}
