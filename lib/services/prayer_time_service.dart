class PrayerTimeService {
  String getPrayerNameInArabic(String prayerName) {
    const Map<String, String> arabicNames = {
      'Fajr': 'الفجر',
      'Dhuhr': 'الظهر',
      'Asr': 'العصر',
      'Maghrib': 'المغرب',
      'Isha': 'العشاء',
    };
    return arabicNames[prayerName] ?? '';
  }
}
