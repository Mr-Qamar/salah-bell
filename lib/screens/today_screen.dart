import 'dart:async';

import 'package:flutter/material.dart';
import '../data/prayers.dart';
import '../state/salah_store.dart';
import 'settings_screen.dart';

const gold = Color(0xFFD4AF37);

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = SalahScope.of(context);
    final next = store.nextPrayer();
    final left = next.left;
    final hours = left.inHours;
    final mins = left.inMinutes.remainder(60);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Salah Bell',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: gold),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          Text(
            '${store.city.name} · ${store.city.country}',
            style: const TextStyle(color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF14532D), Color(0xFF0F172A)],
              ),
              border: Border.all(color: gold.withValues(alpha: 0.35)),
            ),
            child: Column(
              children: [
                const Text('Next prayer', style: TextStyle(color: gold)),
                const SizedBox(height: 6),
                Text(
                  next.prayer.name,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                ),
                Text(
                  next.prayer.arabic,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 22, color: gold),
                ),
                const SizedBox(height: 8),
                Text(
                  'in ${hours}h ${mins}m  ·  ${formatHm(next.at.hour, next.at.minute)}',
                  style: const TextStyle(color: Color(0xFFCBD5E1)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text('Today', style: TextStyle(fontWeight: FontWeight.w700, color: gold)),
          const SizedBox(height: 10),
          for (var i = 0; i < prayers.length; i++)
            _PrayerTile(
              def: prayers[i],
              time: store.city.times[i],
              done: store.prayed.contains(prayers[i].id),
              isNext: prayers[i].id == next.prayer.id,
              onToggle: () => store.togglePrayed(prayers[i].id),
            ),
        ],
      ),
    );
  }
}

class _PrayerTile extends StatelessWidget {
  const _PrayerTile({
    required this.def,
    required this.time,
    required this.done,
    required this.isNext,
    required this.onToggle,
  });

  final PrayerDef def;
  final (int, int) time;
  final bool done;
  final bool isNext;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: isNext ? const Color(0xFF14532D) : const Color(0xFF121A2E),
        borderRadius: BorderRadius.circular(18),
        child: ListTile(
          onTap: onToggle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF1E293B),
            child: Icon(_icon(def.id), color: gold),
          ),
          title: Text(def.name, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(def.arabic, textDirection: TextDirection.rtl),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formatHm(time.$1, time.$2),
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Icon(
                done ? Icons.check_circle : Icons.circle_outlined,
                color: done ? const Color(0xFF34D399) : Colors.white24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _icon(String id) => switch (id) {
        'fajr' => Icons.wb_twilight,
        'dhuhr' => Icons.wb_sunny_outlined,
        'asr' => Icons.cloud_outlined,
        'maghrib' => Icons.nights_stay_outlined,
        _ => Icons.dark_mode_outlined,
      };
}
