class Moodboard {
  const Moodboard({
    required this.id,
    required this.title,
    required this.items,
    required this.createdAt,
    this.coverSpotId,
  });

  final String id;
  final String title;
  final List<MoodboardItem> items;
  final DateTime createdAt;
  final String? coverSpotId;

  int get itemCount => items.length;
}

class MoodboardItem {
  const MoodboardItem({
    required this.spotId,
    this.note,
    required this.addedAt,
  });

  final String spotId;
  final String? note;
  final DateTime addedAt;
}
