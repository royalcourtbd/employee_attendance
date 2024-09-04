// lib/domain/services/holiday_service.dart ফাইলে

class Holiday {
  final DateTime date;
  final String reason;

  Holiday(this.date, this.reason);
}

class HolidayService {
  final List<Holiday> _holidays = [
    Holiday(DateTime(2024, 2, 21), "শহীদ দিবস ও আন্তর্জাতিক মাতৃভাষা দিবস"),
    Holiday(DateTime(2024, 3, 11), "শব-ই-মেরাজ"),
    Holiday(DateTime(2024, 3, 17),
        "জাতির পিতা বঙ্গবন্ধু শেখ মুজিবুর রহমানের জন্মদিবস"),
    Holiday(DateTime(2024, 3, 26), "স্বাধীনতা ও জাতীয় দিবস"),
    Holiday(DateTime(2024, 3, 31), "শব-ই-বরাত"),
    Holiday(DateTime(2024, 4, 10), "রমজান শুরু"),
    Holiday(DateTime(2024, 4, 14), "বাংলা নববর্ষ"),
    Holiday(DateTime(2024, 5, 1), "মে দিবস"),
    Holiday(DateTime(2024, 5, 9), "জুমাতুল বিদা"),
    Holiday(DateTime(2024, 5, 11), "ঈদ-উল-ফিতর"),
    Holiday(DateTime(2024, 6, 17), "পবিত্র ঈদ-ই-মিলাদুন্নবী (সাঃ)"),
    Holiday(DateTime(2024, 6, 28), "পবিত্র অষ্টমী"),
    Holiday(DateTime(2024, 7, 17), "ঈদ-উল-আযহা"),
    Holiday(DateTime(2024, 8, 15), "জাতীয় শোক দিবস"),
    Holiday(DateTime(2024, 8, 26), "জন্মাষ্টমী"),
    Holiday(DateTime(2024, 10, 2), "আশুরা"),
    Holiday(DateTime(2024, 10, 17), "শারদীয় দুর্গোৎসব"),
    Holiday(DateTime(2024, 12, 16), "মহান বিজয় দিবস"),
    Holiday(DateTime(2024, 12, 25), "যীশু খ্রিস্টের জন্মদিন"),
  ];

  bool isHoliday(DateTime date) {
    return _holidays.any((holiday) =>
        holiday.date.year == date.year &&
        holiday.date.month == date.month &&
        holiday.date.day == date.day);
  }

  String? getHolidayReason(DateTime date) {
    final holiday = _holidays.firstWhere(
      (h) =>
          h.date.year == date.year &&
          h.date.month == date.month &&
          h.date.day == date.day,
      orElse: () => Holiday(date, ""),
    );
    return holiday.reason.isNotEmpty ? holiday.reason : null;
  }

  List<Holiday> getHolidaysForMonth(int year, int month) {
    return _holidays
        .where((holiday) =>
            holiday.date.year == year && holiday.date.month == month)
        .toList();
  }
}
