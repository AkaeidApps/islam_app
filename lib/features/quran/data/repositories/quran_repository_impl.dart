import '../../domain/entities/ayah.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_remote_datasource.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource _remote;
  QuranRepositoryImpl(this._remote);

  @override
  Future<List<Surah>> getSurahList() async {
    final models = await _remote.getSurahList();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Ayah>> getSurahAyahs(int surahNumber, String reciter) async {
    final models = await _remote.getSurahWithTranslation(surahNumber, reciter);
    return models.map((m) => m.toEntity()).toList();
  }
}