class PrayerDef {
  const PrayerDef(this.id, this.name, this.arabic);

  final String id;
  final String name;
  final String arabic;
}

const prayers = [
  PrayerDef('fajr', 'Fajr', 'الفجر'),
  PrayerDef('dhuhr', 'Dhuhr', 'الظهر'),
  PrayerDef('asr', 'Asr', 'العصر'),
  PrayerDef('maghrib', 'Maghrib', 'المغرب'),
  PrayerDef('isha', 'Isha', 'العشاء'),
];

class CityTimes {
  const CityTimes(this.id, this.name, this.country, this.qiblaDeg, this.times);

  final String id;
  final String name;
  final String country;
  final double qiblaDeg;
  /// Hour, minute for Fajr, Dhuhr, Asr, Maghrib, Isha.
  final List<(int, int)> times;
}

const cities = [
  CityTimes('lahore', 'Lahore', 'Pakistan', 262, [
    (4, 48),
    (12, 11),
    (15, 42),
    (18, 29),
    (19, 56),
  ]),
  CityTimes('karachi', 'Karachi', 'Pakistan', 268, [
    (5, 12),
    (12, 28),
    (16, 2),
    (18, 47),
    (20, 12),
  ]),
  CityTimes('islamabad', 'Islamabad', 'Pakistan', 261, [
    (4, 41),
    (12, 8),
    (15, 38),
    (18, 24),
    (19, 51),
  ]),
  CityTimes('makkah', 'Makkah', 'Saudi Arabia', 0, [
    (4, 55),
    (12, 20),
    (15, 44),
    (18, 36),
    (20, 6),
  ]),
  CityTimes('madinah', 'Madinah', 'Saudi Arabia', 176, [
    (4, 48),
    (12, 18),
    (15, 41),
    (18, 33),
    (20, 3),
  ]),
];

DateTime todayAt(int hour, int minute, {int dayOffset = 0}) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, hour, minute).add(Duration(days: dayOffset));
}

String formatHm(int hour, int minute) {
  final h = hour % 12 == 0 ? 12 : hour % 12;
  final am = hour < 12 ? 'AM' : 'PM';
  return '$h:${minute.toString().padLeft(2, '0')} $am';
}
