import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  static const route = '/games';
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final games = List.generate(4, (i) => 'Game Prototype ${i + 1}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: games.length,
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          return _GameTile(title: games[index], colorScheme: colorScheme);
        },
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final String title;
  final ColorScheme colorScheme;
  const _GameTile({required this.title, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              colorScheme.secondaryContainer.withOpacity(.18),
              colorScheme.primaryContainer.withOpacity(.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: colorScheme.secondary.withOpacity(.25),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.videogame_asset_rounded, color: colorScheme.secondary, size: 32),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      'Playable soon',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: .5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant)
            ],
          ),
        ),
      ),
    );
  }
}
