import 'package:jdolh_flutter/category/data/datasource/base_remote_category_datasource.dart';
import 'package:jdolh_flutter/category/domain/entities/category_slide.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/category/domain/repository/base_category_repository.dart';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class CategoryRepository extends BaseCategoryRepository {
  final BaseRemoteCategoryDatasource baseRemoteCategoryDatasource;
  CategoryRepository(this.baseRemoteCategoryDatasource);
  ///// get parent categories
  @override
  Future<Either<Failure, List<Category>>> getParentCategories() async {
    final result = await baseRemoteCategoryDatasource.getParentCategories();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

///// get subcategories
  @override
  Future<Either<Failure, List<Category>>> getSubCategories(int categoryId) async {
    final result = await baseRemoteCategoryDatasource.getSubCategories(categoryId);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

///// get stores of categories
  @override
  Future<Either<Failure, List<Store>>> getStoresOfCategory(int categoryId) async {
    final result = await baseRemoteCategoryDatasource.getStoresOfCategory(categoryId);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CategorySlide>>> getCategorySlides() async {
    final result = await baseRemoteCategoryDatasource.getStoreCategorySlide();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.serverErrorModel.message, e.serverErrorModel.statusCode));
    }
  }
}
