import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/dua.dart';
import '../entities/dua_category.dart';

abstract class DuaRepository {
  Future<Either<Failure, List<DuaCategory>>> getDuaCategories();
  Future<Either<Failure, List<Dua>>> getDuasByCategory(String categoryId);
}
