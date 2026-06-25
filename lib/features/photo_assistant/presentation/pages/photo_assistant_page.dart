import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/create_context_provider.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../../spot/domain/entities/spot.dart';

class _ChatMessage {
  const _ChatMessage({required this.text, required this.isUser});
  final String text;
  final bool isUser;
}

class PhotoAssistantPage extends ConsumerStatefulWidget {
  const PhotoAssistantPage({super.key});

  @override
  ConsumerState<PhotoAssistantPage> createState() =>
      _PhotoAssistantPageState();
}

class _PhotoAssistantPageState extends ConsumerState<PhotoAssistantPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _messages = <_ChatMessage>[];
  bool _isTyping = false;
  String _streamedText = '';
  Timer? _streamTimer;

  static const _quickQuestions = [
    'How should I pose here?',
    'Which lens is best?',
    'What is the best angle?',
    'When is crowd lowest?',
    'What should I wear?',
    'Best time of day?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _streamTimer?.cancel();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _ask(String question) {
    if (question.trim().isEmpty || _isTyping) return;

    final spotId = ref.read(createContextSpotIdProvider);
    final spot =
        spotId != null ? ref.read(spotByIdProvider(spotId)) : null;

    setState(() {
      _messages.add(_ChatMessage(text: question, isUser: true));
      _isTyping = true;
      _streamedText = '';
      _controller.clear();
    });
    _scrollToBottom();

    final fullAnswer = _generateAnswer(question, spot);
    _streamResponse(fullAnswer);
  }

  void _streamResponse(String fullText) {
    int charIndex = 0;
    _streamTimer?.cancel();
    _streamTimer = Timer.periodic(const Duration(milliseconds: 18), (timer) {
      if (charIndex >= fullText.length) {
        timer.cancel();
        setState(() {
          _messages.add(_ChatMessage(text: fullText, isUser: false));
          _isTyping = false;
          _streamedText = '';
        });
        _scrollToBottom();
        return;
      }
      setState(() {
        _streamedText = fullText.substring(0, charIndex + 1);
      });
      charIndex++;
      _scrollToBottom();
    });
  }

  String _generateAnswer(String q, Spot? spot) {
    final place = spot?.name ?? 'this location';
    final lower = q.toLowerCase();

    if (lower.contains('pose') || lower.contains('poz')) {
      return 'At $place I\'d suggest these poses:\n\n'
          '1. **The Candid Walk** — Mid-stride, looking slightly away. Camera at waist height, 35mm lens.\n\n'
          '2. **The Lean** — Rest against a wall or railing, one foot crossed. Weight on back hip for a natural S-curve.\n\n'
          '3. **The Look-Back** — Walk away from camera, turn head 3/4 over shoulder. Works great for Reels transitions.\n\n'
          '💡 Pro tip: Shoot burst mode during movement for authentic-feeling captures.';
    }
    if (lower.contains('lens') || lower.contains('objektif')) {
      return 'Lens guide for $place:\n\n'
          '• **35mm f/2.0** — Best all-around for environmental portraits. Shows context without distortion.\n\n'
          '• **50mm f/1.8** — Flattering compression for headshots and detail shots. Creamy bokeh.\n\n'
          '• **16-24mm** — Use sparingly for dramatic architecture/scale. Keep subject near center to avoid wide-angle stretch.\n\n'
          '📱 Phone tip: Use 1x (26mm) for most shots, 2x for portraits.';
    }
    if (lower.contains('angle') || lower.contains('açı')) {
      return 'Best angles at $place:\n\n'
          '• **Slightly below eye level** — Creates a flattering, confident look. Include skyline or architecture above.\n\n'
          '• **Rule of thirds** — Place subject on the left or right vertical third. Never dead center unless intentional.\n\n'
          '• **Leading lines** — Use paths, railings, or shadows to draw the eye toward your subject.\n\n'
          '🎯 Frame the shot first without your subject, then step in.';
    }
    if (lower.contains('crowd') || lower.contains('kalabalık')) {
      final bestTime = spot?.bestTimeLabel;
      return bestTime != null
          ? 'Crowd intel for $place:\n\n'
              '⏰ **Sweet spot:** $bestTime — arrive 30 min early to scout your composition.\n\n'
              '🌅 **Lowest crowds:** Within 1 hour of opening, or during golden hour when day-trippers leave.\n\n'
              '📅 **Weekday vs weekend:** Weekday mornings can have 60-70% fewer people.\n\n'
              '💡 Use long exposure (1-2s) with ND filter to blur out remaining people.'
          : 'General crowd strategy:\n\n'
              '⏰ Crowds peak 11:00–16:00 at most spots.\n\n'
              '🌅 Go within 1 hour of opening or during golden hour.\n\n'
              '📅 Weekdays are dramatically quieter than weekends.\n\n'
              '💡 Long exposure (1-2s) with an ND filter can make crowds disappear.';
    }
    if (lower.contains('wear') || lower.contains('outfit') ||
        lower.contains('giy') || lower.contains('kombin')) {
      return 'Outfit guidance for $place:\n\n'
          '• **Solid colors** photograph best — avoid busy patterns that compete with the background.\n\n'
          '• **Earth tones + one accent** — Beige, cream, sage green, then one pop of color (terracotta, gold, or navy).\n\n'
          '• **Texture over print** — Linen, knit, silk catch light beautifully.\n\n'
          '• **Layers** — A light jacket or scarf gives you 3 outfits in 1 location.\n\n'
          '👠 Shoes matter! They\'re visible in full-body shots more than you think.';
    }
    if (lower.contains('time') || lower.contains('zaman') ||
        lower.contains('saat') || lower.contains('when')) {
      final bestTime = spot?.bestTimeLabel;
      return bestTime != null
          ? 'Best shooting times at $place:\n\n'
              '🌅 **Golden hour:** $bestTime — warm light, long shadows, magic vibes.\n\n'
              '🌤 **Blue hour:** 20-30 min after sunset — moody, cinematic look.\n\n'
              '☀️ **Harsh midday:** Use shade or backlight your subject against the sun for a halo effect.\n\n'
              '🌙 **Night:** Tripod + 2-4s exposure for city lights. ISO 800 max to keep noise low.'
          : 'Shooting time strategy:\n\n'
              '🌅 **Golden hour** — The hour after sunrise and before sunset. Non-negotiable for the best light.\n\n'
              '🌤 **Blue hour** — 20-30 min after sunset for moody tones.\n\n'
              '☀️ **Midday** — Use shade, or backlight for a sun-halo effect.\n\n'
              '🌙 **Night** — Tripod essential. ISO 800 max, 2-4s exposure.';
    }
    return 'Here\'s my advice for shooting at $place:\n\n'
        '1. **Scout first** — Walk the area for 10 min before shooting. Find unique angles others miss.\n\n'
        '2. **Light is everything** — Position yourself so light falls on your face, not behind you (unless going for silhouette).\n\n'
        '3. **Move naturally** — The best content comes from authentic movement, not stiff poses.\n\n'
        '4. **Shoot more than you think** — Take 50+ photos per setup. Your best shot is often frame #37.\n\n'
        '✨ Most importantly: have fun. Confidence shows in photos.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final spotId = ref.watch(createContextSpotIdProvider);
    final spot = spotId != null ? ref.watch(spotByIdProvider(spotId)) : null;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(l10n.photoAssistant)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _WelcomeBubble(spotName: spot?.name),
                if (_messages.isEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: _quickQuestions
                        .map(
                          (q) => ActionChip(
                            label: Text(q),
                            onPressed: () => _ask(q),
                          ),
                        )
                        .toList(),
                  ),
                ],
                ..._messages.map((msg) => _ChatBubble(message: msg)),
                if (_isTyping && _streamedText.isNotEmpty)
                  _StreamingBubble(text: _streamedText),
                if (_isTyping && _streamedText.isEmpty)
                  const _TypingIndicator(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.xs,
              AppSpacing.md,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.5),
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: _ask,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: 'Ask about pose, lens, timing…',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLg),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  IconButton.filled(
                    onPressed: _isTyping
                        ? null
                        : () => _ask(_controller.text),
                    icon: const Icon(Icons.send_rounded, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBubble extends StatelessWidget {
  const _WelcomeBubble({this.spotName});
  final String? spotName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.gold, size: 22),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Photo Assistant',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.gold),
                ),
                const SizedBox(height: 4),
                Text(
                  spotName != null
                      ? 'Ask me anything about shooting at $spotName — poses, lens, timing, outfit, angles.'
                      : 'Ask me anything about photography — poses, lens choices, timing, outfits, and composition.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});
  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: AppSpacing.sm),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? AppColors.gold
              : theme.cardColor,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: message.isUser
                ? const Radius.circular(4)
                : null,
            bottomLeft: !message.isUser
                ? const Radius.circular(4)
                : null,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: message.isUser ? AppColors.white : null,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.05, end: 0);
  }
}

class _StreamingBubble extends StatelessWidget {
  const _StreamingBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: AppSpacing.sm),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomLeft: const Radius.circular(4),
          ),
        ),
        child: Text(text, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .fadeIn(duration: 400.ms, delay: (150 * i).ms)
                .then()
                .fadeOut(duration: 400.ms);
          }),
        ),
      ),
    );
  }
}
