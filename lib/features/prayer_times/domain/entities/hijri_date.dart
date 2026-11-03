class HijriDate {
  final String date;
  final String day;
  final int monthNumber;
  final String monthEn;
  final String monthAr;
  final String year;
  final String designationAbbreviated;
  final String designationExpanded;

  const HijriDate({
    required this.date,
    required this.day,
    required this.monthNumber,
    required this.monthEn,
    required this.monthAr,
    required this.year,
    required this.designationAbbreviated,
    required this.designationExpanded,
  });

  factory HijriDate.fromJson(Map<String, dynamic> j) {
    final month = j['month'] as Map<String, dynamic>;
    final designation = j['designation'] as Map<String, dynamic>;
    return HijriDate(
      date: j['date'] as String,
      day: j['day'] as String,
      monthNumber: month['number'] as int,
      monthEn: month['en'] as String,
      monthAr: month['ar'] as String? ?? '',
      year: j['year'] as String,
      designationAbbreviated: designation['abbreviated'] as String,
      designationExpanded: designation['expanded'] as String,
    );
  }

  /// Formatted string like "14 Ramadan 1447 AH"
  String get formatted => '$day $monthEn $year AH';
  
  /// Arabic formatted string like "١٤ رمضان ١٤٤٧ هـ"
  String get formattedArabic => '$date $monthAr $year $designationAbbreviated';
}
