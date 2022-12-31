import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/store/data/datasource/base_remote_store_datasource.dart';
import 'package:jdolh_flutter/store/domain/entities/store_details.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/store/domain/repository/base_store_repository.dart';

class StoreRepository extends BaseStoreRepository {
  final BaseRemoteStoreDatasource baseRemoteStoreDatasource;
  StoreRepository(this.baseRemoteStoreDatasource);

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails(int storeId) async {
    final result = await baseRemoteStoreDatasource.getStoreDetails(storeId);

    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }
}
