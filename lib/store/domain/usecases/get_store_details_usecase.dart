import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/store/domain/entities/store_details.dart';
import 'package:jdolh_flutter/store/domain/repository/base_store_repository.dart';

class GetStoreDetailsUsecase {
  final BaseStoreRepository baseStoreRepository;
  const GetStoreDetailsUsecase(this.baseStoreRepository);

  Future<Either<Failure, StoreDetails>> call(int storeId) async {
    return baseStoreRepository.getStoreDetails(storeId);
  }
}
