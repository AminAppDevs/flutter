import 'package:dartz/dartz.dart';
import 'package:jdolh_flutter/category/domain/entities/category_slide.dart';
import 'package:jdolh_flutter/category/domain/repository/base_category_repository.dart';
import 'package:jdolh_flutter/core/error/failure.dart';

class GetStoreCategorySlidesUsecase {
  final BaseCategoryRepository baseCategoryRepository;
  GetStoreCategorySlidesUsecase(this.baseCategoryRepository);

  Future<Either<Failure, List<CategorySlide>>> call() async {
    return baseCategoryRepository.getCategorySlides();
  }
}
