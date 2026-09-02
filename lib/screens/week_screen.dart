import 'package:flutter/material.dart';
import '../data/prayers.dart';
import '../state/salah_store.dart';

const gold = Color(0xFFD4AF37);

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalahScope.of(context);
    final now = DateTime.now();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          const Text(
            'This week',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: gold),
          ),
          Text(
            'Times shift slightly each day · ${store.city.name}',
            style: const TextStyle(color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 16),
          for (var d = 0; d < 7; d++)
            _DayCard(
              date: now.add(Duration(days: d)),
              times: [
                for (final t in store.city.times)
                  (t.$1, (t.$2 + d) % 60),
              ],
              isToday: d == 0,
            ),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.date,
    required this.times,
    required this.isToday,
  });

  final DateTime date;
  final List<(int, int)> times;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    const names = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    final label = '${_wd(date.weekday)}  ${date.day}/${date.month}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isToday ? const Color(0xFF14532D) : const Color(0xFF121A2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isToday ? gold.withValues(alpha: 0.4) : Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isToday ? '$label  ·  Today' : label,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var i = 0; i < names.length; i++)
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        names[i],
                        style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatHm(times[i].$1, times[i].$2).replaceAll(' AM', '').replaceAll(' PM', ''),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  static String _wd(int d) =>
      const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d - 1];
}
