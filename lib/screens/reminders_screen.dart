import 'package:flutter/material.dart';
import '../data/prayers.dart';
import '../state/salah_store.dart';

const gold = Color(0xFFD4AF37);

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  static const offsets = [0, 5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    final store = SalahScope.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          const Text(
            'Reminders',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: gold),
          ),
          const Text(
            'Adhan alerts are demo-only — no system notification is scheduled.',
            style: TextStyle(color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 16),
          for (final p in prayers)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: const Color(0xFF121A2E),
                borderRadius: BorderRadius.circular(18),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SwitchListTile(
                      value: store.remindOn[p.id] ?? true,
                      activeThumbColor: gold,
                      title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: Text(p.arabic, textDirection: TextDirection.rtl),
                      onChanged: (_) => store.toggleRemind(p.id),
                    ),
                    if (store.remindOn[p.id] ?? true)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 4),
                        child: Row(
                          children: [
                            const Text('Remind', style: TextStyle(color: Color(0xFF94A3B8))),
                            const Spacer(),
                            DropdownButton<int>(
                              value: store.remindBefore[p.id] ?? 10,
                              dropdownColor: const Color(0xFF1E293B),
                              items: [
                                for (final m in offsets)
                                  DropdownMenuItem(
                                    value: m,
                                    child: Text(m == 0 ? 'At adhan' : '$m min before'),
                                  ),
                              ],
                              onChanged: (v) {
                                if (v != null) store.setBefore(p.id, v);
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test adhan played (demo)')),
              );
            },
            icon: const Icon(Icons.volume_up_outlined),
            label: const Text('Test adhan'),
          ),
        ],
      ),
    );
  }
}
