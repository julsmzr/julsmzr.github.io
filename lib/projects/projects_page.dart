import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  static const route = '/projects';
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final projects = List.generate(6, (i) => 'Project ${i + 1}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.15,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _ProjectCard(title: projects[index], colorScheme: colorScheme);
          },
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final ColorScheme colorScheme;
  const _ProjectCard({required this.title, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withOpacity(.18),
            colorScheme.secondaryContainer.withOpacity(.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: colorScheme.primary.withOpacity(.25),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(.18),
            blurRadius: 24,
            spreadRadius: -4,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.auto_awesome, color: colorScheme.primary, size: 32),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Coming soon',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: .5,
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
