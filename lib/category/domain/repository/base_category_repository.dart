import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/category/domain/entities/category_slide.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

abstract class BaseCategoryRepository {
  Future<Either<Failure, List<Category>>> getParentCategories();
  Future<Either<Failure, List<Category>>> getSubCategories(int categoryId);
  Future<Either<Failure, List<Store>>> getStoresOfCategory(int categoryId);
  Future<Either<Failure, List<CategorySlide>>> getCategorySlides();
}
