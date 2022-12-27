import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_parent_categories_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_stores_of_category_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_subcategories_usecase.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';

class CategoryController extends GetxController {
  final GetParentCategoriesUsecase getParentCategoriesUsecase;
  final GetSubCategoriesUsecase getSubCategoriesUsecase;
  final GetStoresOfCategoryUsecase getStoresOfCategoryUsecase;
  CategoryController(this.getParentCategoriesUsecase, this.getSubCategoriesUsecase, this.getStoresOfCategoryUsecase);
  ///// on init
  @override
  void onInit() {
    super.onInit();
  }

  ///// variables
  List<Category> parentCategories = [];
  List<Category> subCategories = [];
  List<Store> storesOfCategory = [];
  bool isParentCategoriesLoading = false;
  bool isSubCategoriesLoading = false;
  bool isStoreOfCategoryLoading = false;

  ///// get parent categories
  getParentCategories() async {
    isParentCategoriesLoading = true;
    update();

    Either<Failure, List<Category>> result = await getParentCategoriesUsecase();
    result.fold(
      (Failure failure) {
        isParentCategoriesLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
      },
      (List<Category> categories) {
        isParentCategoriesLoading = false;
        parentCategories = categories;
        update();
      },
    );
  }

  ///// get subcategories
  getSubCategories(int categoryId) async {
    isSubCategoriesLoading = true;
    update();

    Either<Failure, List<Category>> result = await getSubCategoriesUsecase(categoryId);
    result.fold(
      (Failure failure) {
        isSubCategoriesLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
      },
      (List<Category> categories) {
        isSubCategoriesLoading = false;
        subCategories = categories;
        update();
      },
    );
  }

  ///// get stores of category
  getStoresOfCategory(int categoryId) async {
    isStoreOfCategoryLoading = true;
    update();

    Either<Failure, List<Store>> result = await getStoresOfCategoryUsecase(categoryId);
    result.fold(
      (Failure failure) {
        isStoreOfCategoryLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
      },
      (List<Store> stores) {
        isStoreOfCategoryLoading = false;
        storesOfCategory = stores;
        update();
      },
    );
  }
}
