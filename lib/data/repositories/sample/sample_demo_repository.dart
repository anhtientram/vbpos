import 'package:core/core.dart';

import '../../../domains/entities/sample/sample_entities.dart';
import '../../../domains/repositories/sample/sample_repository.dart';

class SampleDemoRepository implements SampleRepository {
  SampleDemoRepository()
    : _items = [
        SampleItemEntities(
          id: 'sample-1',
          name: 'Mục mẫu đầu tiên',
          description: 'Dữ liệu local để mở app và xem ngay module mẫu.',
          createdAt: DateTime(2026, 1, 1, 9),
        ),
      ];

  final List<SampleItemEntities> _items;

  @override
  AsyncEither<List<SampleItemEntities>> getItems() async => right(
    List.unmodifiable(_items),
  );

  @override
  AsyncEither<SampleItemEntities> createItem(
    CreateSampleItemParams params,
  ) async {
    final item = SampleItemEntities(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: params.name,
      description: params.description,
      createdAt: DateTime.now(),
    );
    _items.insert(0, item);
    return right(item);
  }
}
