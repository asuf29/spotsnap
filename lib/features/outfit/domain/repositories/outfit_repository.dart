import '../entities/outfit_concept.dart';

abstract class OutfitRepository {
  List<OutfitConcept> getConcepts({String? cityId});

  List<WardrobeItem> getWardrobe();

  List<String> suggestOutfitItems(String conceptId, List<String> wardrobeIds);
}
