import '../entities/ayah.dart';
import '../entities/surah.dart';

abstract interface class QuranRepository {
  Future<List<Surah>> getSurahList();
  Future<List<Ayah>> getSurahAyahs(int surahNumber, String reciter);
}