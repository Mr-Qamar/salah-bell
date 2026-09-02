import 'package:flutter/material.dart';
import '../data/prayers.dart';

class SalahStore extends ChangeNotifier {
  String cityId = 'lahore';
  String method = 'Karachi (University of Islamic Sciences)';
  final prayed = <String>{};
  final remindOn = {for (final p in prayers) p.id: true};
  final remindBefore = {for (final p in prayers) p.id: 10};

  CityTimes get city => cities.firstWhere((c) => c.id == cityId);

  void setCity(String id) {
    cityId = id;
    notifyListeners();
  }

  void setMethod(String value) {
    method = value;
    notifyListeners();
  }

  void togglePrayed(String id) {
    if (!prayed.add(id)) prayed.remove(id);
    notifyListeners();
  }

  void toggleRemind(String id) {
    remindOn[id] = !(remindOn[id] ?? true);
    notifyListeners();
  }

  void setBefore(String id, int minutes) {
    remindBefore[id] = minutes;
    notifyListeners();
  }

  ({PrayerDef prayer, DateTime at, Duration left}) nextPrayer() {
    final now = DateTime.now();
    for (var i = 0; i < prayers.length; i++) {
      final t = city.times[i];
      final at = todayAt(t.$1, t.$2);
      if (at.isAfter(now)) {
        return (prayer: prayers[i], at: at, left: at.difference(now));
      }
    }
    final t = city.times.first;
    final at = todayAt(t.$1, t.$2, dayOffset: 1);
    return (prayer: prayers.first, at: at, left: at.difference(now));
  }
}

class SalahScope extends InheritedNotifier<SalahStore> {
  const SalahScope({super.key, required SalahStore store, required super.child})
      : super(notifier: store);

  static SalahStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SalahScope>();
    assert(scope != null, 'SalahScope not found');
    return scope!.notifier!;
  }
}
