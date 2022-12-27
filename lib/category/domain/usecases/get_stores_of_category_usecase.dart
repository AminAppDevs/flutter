import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/category/domain/repository/base_category_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class GetStoresOfCategoryUsecase {
  final BaseCategoryRepository baseCategoryRepository;
  const GetStoresOfCategoryUsecase(this.baseCategoryRepository);

  Future<Either<Failure, List<Store>>> call(int categoryId) async {
    return await baseCategoryRepository.getStoresOfCategory(categoryId);
  }
}
