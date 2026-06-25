import 'package:flutter/material.dart';

import '../../domain/entities/outfit_concept.dart';

class OutfitSeedData {
  OutfitSeedData._();

  static const concepts = [
    OutfitConcept(
      id: 'paris-morning',
      name: 'Paris morning neutral',
      description: 'Soft neutrals, trench & café-ready layers.',
      palette: [
        Color(0xFFE8E2D9),
        Color(0xFFC4B8A8),
        Color(0xFF8B7E6A),
        Color(0xFFFAFAF8),
      ],
      items: ['Beige trench', 'Cream knit', 'White sneakers', 'Structured bag'],
      weatherNote: '15°C · Light wind — layer a thin scarf',
      cityIds: ['paris'],
    ),
    OutfitConcept(
      id: 'santorini-white',
      name: 'Santorini white-blue',
      description: 'Crisp whites with Aegean blue accents.',
      palette: [
        Color(0xFFFAFAF8),
        Color(0xFFE8F0F5),
        Color(0xFF6B9AC4),
        Color(0xFFC9A962),
      ],
      items: ['White linen dress', 'Gold sandals', 'Woven bag', 'Cat-eye sunglasses'],
      weatherNote: '26°C · Strong sun — SPF 50+',
      cityIds: ['santorini'],
    ),
    OutfitConcept(
      id: 'tokyo-night',
      name: 'Tokyo streetwear night',
      description: 'Oversized layers & neon-friendly dark tones.',
      palette: [
        Color(0xFF0A0A0A),
        Color(0xFF2C2C2E),
        Color(0xFF6B6B6B),
        Color(0xFFC9A962),
      ],
      items: ['Black cargo pants', 'Oversized bomber', 'Platform boots', 'Crossbody bag'],
      weatherNote: '18°C · Humid evening',
      cityIds: ['tokyo', 'seoul'],
    ),
    OutfitConcept(
      id: 'istanbul-sunset',
      name: 'İstanbul sunset warm',
      description: 'Earth tones for golden Bosphorus hour.',
      palette: [
        Color(0xFFE8D4C4),
        Color(0xFFC9A962),
        Color(0xFF8B5E3C),
        Color(0xFF4A3728),
      ],
      items: ['Rust midi skirt', 'Cream blouse', 'Leather ankle boots', 'Gold earrings'],
      weatherNote: '22°C · Clear — perfect golden hour',
      cityIds: ['istanbul'],
    ),
    OutfitConcept(
      id: 'seoul-clean',
      name: 'Seoul clean girl cafe',
      description: 'Minimal pastels, soft textures.',
      palette: [
        Color(0xFFF5E6E8),
        Color(0xFFE5EDE8),
        Color(0xFFFAFAF8),
        Color(0xFFD4C4B0),
      ],
      items: ['Pastel cardigan', 'Wide-leg trousers', 'Ballet flats', 'Mini shoulder bag'],
      weatherNote: '12°C · Bring light coat',
      cityIds: ['seoul'],
    ),
    OutfitConcept(
      id: 'beach-aesthetic',
      name: 'Beach aesthetic flow',
      description: 'Light fabrics, effortless movement.',
      palette: [
        Color(0xFFE8F0F5),
        Color(0xFFFAFAF8),
        Color(0xFFE5EDE8),
        Color(0xFFC9A962),
      ],
      items: ['Linen co-ord', 'Straw hat', 'Barefoot sandals', 'Shell jewelry'],
      weatherNote: '28°C · Beach wind — avoid heavy fabrics',
    ),
  ];

  static const wardrobe = [
    WardrobeItem(
      id: 'w1',
      name: 'White linen shirt',
      category: 'Tops',
      color: Color(0xFFFAFAF8),
    ),
    WardrobeItem(
      id: 'w2',
      name: 'Black wide pants',
      category: 'Bottoms',
      color: Color(0xFF0A0A0A),
    ),
    WardrobeItem(
      id: 'w3',
      name: 'Beige trench',
      category: 'Outerwear',
      color: Color(0xFFE8E2D9),
    ),
    WardrobeItem(
      id: 'w4',
      name: 'Gold hoop earrings',
      category: 'Accessories',
      color: Color(0xFFC9A962),
    ),
    WardrobeItem(
      id: 'w5',
      name: 'Navy midi dress',
      category: 'Dresses',
      color: Color(0xFF2C3E50),
    ),
    WardrobeItem(
      id: 'w6',
      name: 'White sneakers',
      category: 'Shoes',
      color: Color(0xFFF5F5F5),
    ),
  ];
}
