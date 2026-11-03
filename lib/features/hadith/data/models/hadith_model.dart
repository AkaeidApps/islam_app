class HadithModel {
  final int id;
  final String title;
  final String arabic;
  final String bengali;
  final String source;
  const HadithModel({
    required this.id,
    required this.title,
    required this.arabic,
    required this.bengali,
    required this.source,
  });

  factory HadithModel.fromJson(Map<String, dynamic> j) => HadithModel(
    id: j['id'] as int,
    title: j['title'] as String,
    arabic: j['arabic'] as String,
    bengali: j['bengali'] as String,
    source: j['source'] as String,
  );
}