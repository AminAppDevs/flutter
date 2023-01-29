import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/store/domain/entities/product_details.dart';
import 'package:jdolh_flutter/store/domain/repository/base_store_repository.dart';

class GetProductDetailsUsecase {
  final BaseStoreRepository baseStoreRepository;
  const GetProductDetailsUsecase(this.baseStoreRepository);
  Future<Either<Failure, ProductDetails>> call(int productId) async {
    return baseStoreRepository.getProductDetails(productId);
  }
}
