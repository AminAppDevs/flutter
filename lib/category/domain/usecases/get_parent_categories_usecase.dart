import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/category/domain/repository/base_category_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class GetParentCategoriesUsecase {
  final BaseCategoryRepository baseCategoryRepository;
  const GetParentCategoriesUsecase(this.baseCategoryRepository);

  Future<Either<Failure, List<Category>>> call() async {
    return await baseCategoryRepository.getParentCategories();
  }
}
