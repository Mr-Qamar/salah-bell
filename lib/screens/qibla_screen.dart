import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../state/salah_store.dart';

const gold = Color(0xFFD4AF37);

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double _heading = 28;

  @override
  Widget build(BuildContext context) {
    final store = SalahScope.of(context);
    final qibla = store.city.qiblaDeg;
    final needle = (qibla - _heading) * math.pi / 180;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Qibla',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: gold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${store.city.name} · ${qibla.toStringAsFixed(0)}° from North',
                style: const TextStyle(color: Color(0xFF94A3B8)),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: gold, width: 3),
                      color: const Color(0xFF121A2E),
                    ),
                  ),
                  const Positioned(top: 16, child: Text('N', style: TextStyle(fontWeight: FontWeight.w800, color: gold))),
                  Transform.rotate(
                    angle: needle,
                    child: const Icon(Icons.navigation, size: 96, color: gold),
                  ),
                  const Icon(Icons.mosque, color: Colors.white70),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text('Calibrate heading', style: TextStyle(color: Color(0xFF94A3B8))),
            Slider(
              value: _heading,
              min: 0,
              max: 359,
              activeColor: gold,
              onChanged: (v) => setState(() => _heading = v),
            ),
            Text('${_heading.round()}° phone heading'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
