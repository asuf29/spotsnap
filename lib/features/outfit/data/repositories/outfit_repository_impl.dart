import '../../domain/entities/outfit_concept.dart';
import '../../domain/repositories/outfit_repository.dart';
import '../datasources/outfit_seed_data.dart';

class OutfitRepositoryImpl implements OutfitRepository {
  const OutfitRepositoryImpl();

  @override
  List<OutfitConcept> getConcepts({String? cityId}) {
    if (cityId == null) return OutfitSeedData.concepts;
    final filtered = OutfitSeedData.concepts
        .where((c) => c.cityIds.isEmpty || c.cityIds.contains(cityId))
        .toList();
    return filtered.isEmpty ? OutfitSeedData.concepts : filtered;
  }

  @override
  List<WardrobeItem> getWardrobe() => OutfitSeedData.wardrobe;

  @override
  List<String> suggestOutfitItems(String conceptId, List<String> wardrobeIds) {
    for (final concept in OutfitSeedData.concepts) {
      if (concept.id == conceptId) return concept.items;
    }
    return [];
  }
}
