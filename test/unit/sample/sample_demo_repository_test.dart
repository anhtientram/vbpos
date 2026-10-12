import 'package:flutter_test/flutter_test.dart';

import 'package:vbpos/data/repositories/sample/sample_demo_repository.dart';
import 'package:vbpos/domains/entities/sample/sample_entities.dart';

void main() {
  test('creates a sample item with a right value', () async {
    final repository = SampleDemoRepository();

    final result = await repository.createItem(
      const CreateSampleItemParams(name: 'New item'),
    );

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('Expected a right value'),
      (item) => expect(item.name, 'New item'),
    );
  });
}
