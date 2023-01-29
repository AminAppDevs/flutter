import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/store/domain/entities/product_category.dart';
import 'package:jdolh_flutter/store/domain/repository/base_store_repository.dart';

class GetStoreProductCategoryUsecase {
  final BaseStoreRepository baseStoreRepository;
  const GetStoreProductCategoryUsecase(this.baseStoreRepository);

  Future<Either<Failure, List<ProductCategory>>> call(int storeId) async {
    return await baseStoreRepository.getStoreProductCategories(storeId);
  }
}
