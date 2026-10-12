class SampleItemEntities {
  const SampleItemEntities({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
  });

  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
}

class CreateSampleItemParams {
  const CreateSampleItemParams({required this.name, this.description});

  final String name;
  final String? description;
}
