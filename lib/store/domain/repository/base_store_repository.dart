import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/store/domain/entities/store_details.dart';

abstract class BaseStoreRepository {
  Future<Either<Failure, StoreDetails>> getStoreDetails(int storeId);
}
