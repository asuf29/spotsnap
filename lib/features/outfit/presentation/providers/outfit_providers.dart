import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/create_context_provider.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../data/repositories/outfit_repository_impl.dart';
import '../../domain/entities/outfit_concept.dart';
import '../../domain/repositories/outfit_repository.dart';

final outfitRepositoryProvider = Provider<OutfitRepository>(
  (ref) => const OutfitRepositoryImpl(),
);

final selectedOutfitConceptIdProvider = StateProvider<String?>((ref) => null);

final outfitConceptsProvider = Provider<List<OutfitConcept>>((ref) {
  final spotId = ref.watch(createContextSpotIdProvider);
  final cityId =
      spotId != null ? ref.watch(spotByIdProvider(spotId))?.cityId : null;
  return ref.watch(outfitRepositoryProvider).getConcepts(cityId: cityId);
});

final wardrobeProvider = Provider((ref) {
  return ref.watch(outfitRepositoryProvider).getWardrobe();
});

final selectedWardrobeIdsProvider = StateProvider<Set<String>>((ref) => {});

final outfitSuggestionProvider = Provider<List<String>>((ref) {
  final conceptId = ref.watch(selectedOutfitConceptIdProvider);
  if (conceptId == null) return [];
  final wardrobeIds = ref.watch(selectedWardrobeIdsProvider).toList();
  return ref.watch(outfitRepositoryProvider).suggestOutfitItems(
        conceptId,
        wardrobeIds,
      );
});
