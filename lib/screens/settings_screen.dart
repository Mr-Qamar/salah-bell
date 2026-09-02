import 'package:flutter/material.dart';
import '../data/prayers.dart';
import '../state/salah_store.dart';

const gold = Color(0xFFD4AF37);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const methods = [
    'Karachi (University of Islamic Sciences)',
    'Muslim World League',
    'Umm al-Qura, Makkah',
    'Egyptian General Authority',
    'ISNA',
  ];

  @override
  Widget build(BuildContext context) {
    final store = SalahScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const Text('City', style: TextStyle(fontWeight: FontWeight.w700, color: gold)),
          const SizedBox(height: 8),
          for (final c in cities)
            _PickTile(
              title: c.name,
              subtitle: c.country,
              selected: store.cityId == c.id,
              onTap: () => store.setCity(c.id),
            ),
          const SizedBox(height: 16),
          const Text('Calculation method', style: TextStyle(fontWeight: FontWeight.w700, color: gold)),
          const SizedBox(height: 8),
          for (final m in methods)
            _PickTile(
              title: m,
              selected: store.method == m,
              onTap: () => store.setMethod(m),
            ),
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'Prayer times follow the selected city and method.',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickTile extends StatelessWidget {
  const _PickTile({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? const Color(0xFF14532D) : const Color(0xFF121A2E),
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          onTap: onTap,
          title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          subtitle: subtitle == null ? null : Text(subtitle!),
          trailing: Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            color: selected ? gold : Colors.white24,
          ),
        ),
      ),
    );
  }
}
