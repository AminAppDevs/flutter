import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/category/domain/repository/base_category_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class GetSubCategoriesUsecase {
  final BaseCategoryRepository baseCategoryRepository;
  const GetSubCategoriesUsecase(this.baseCategoryRepository);

  Future<Either<Failure, List<Category>>> call(int categoryId) async {
    return await baseCategoryRepository.getSubCategories(categoryId);
  }
}
