import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/dua.dart';
import '../../domain/entities/dua_category.dart';
import '../../domain/repositories/dua_repository.dart';
import '../datasources/dua_remote_datasource.dart';

class DuaRepositoryImpl implements DuaRepository {
  final DuaRemoteDatasource remoteDatasource;

  DuaRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<DuaCategory>>> getDuaCategories() async {
    try {
      final categories = await remoteDatasource.getDuaCategories();
      final categoryEntities = categories.map((model) => DuaCategory(
        id: model.id,
        name: model.name,
        description: model.description,
        duaCount: model.duaCount,
      )).toList();
      return Right(categoryEntities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Dua>>> getDuasByCategory(String categoryId) async {
    try {
      final duas = await remoteDatasource.getDuasByCategory(categoryId);
      final duaEntities = duas.map((model) => Dua(
        id: model.id,
        title: model.title,
        arabicText: model.arabicText,
        arabic: model.arabic,
        translation: model.translation,
        transliteration: model.transliteration,
        categoryId: model.categoryId,
        source: model.source,
      )).toList();
      return Right(duaEntities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
