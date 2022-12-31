import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/category/domain/entities/category_slide.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_parent_categories_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_store_category_slide_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_stores_of_category_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_subcategories_usecase.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';

class CategoryController extends GetxController {
  final GetParentCategoriesUsecase getParentCategoriesUsecase;
  final GetSubCategoriesUsecase getSubCategoriesUsecase;
  final GetStoresOfCategoryUsecase getStoresOfCategoryUsecase;
  final GetStoreCategorySlidesUsecase getStoreCategorySlidesUsecase;
  CategoryController(
      this.getParentCategoriesUsecase, this.getSubCategoriesUsecase, this.getStoresOfCategoryUsecase, this.getStoreCategorySlidesUsecase);
  ///// on init
  @override
  void onInit() {
    super.onInit();
    getParentCategories();
    getStoreCategorySlide();
  }

  ///// variables
  List<Category> parentCategories = [];
  List<Category> subCategories = [];
  List<Store> storesOfCategory = [];
  List<CategorySlide> categorySlides = [];
  bool isParentCategoriesLoading = false;
  bool isSubCategoriesLoading = false;
  bool isStoreOfCategoryLoading = false;
  bool isCategorySlidesLoading = false;
  int activeParentCategory = 0;
  int activeSubcategory = 0;
  bool activeCategoryOpen = false;

  ///// update active parent category
  updateActiveParentCategory(int id) {
    activeParentCategory = id;
    update();
  }

  ///// update active subcategory
  updateActiveSubCategory(int id) {
    activeSubcategory = id;
    update();
  }

  ///// update active category open
  updateActiveCategoryOpen(int id) {
    if (activeParentCategory == id) {
      activeCategoryOpen = !activeCategoryOpen;
      update();
    } else {
      activeCategoryOpen = true;
      update();
    }
  }

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
        if (categories.isNotEmpty) {
          if (categories[0].subCategories.isNotEmpty) {
            getStoresOfCategory(categories[0].subCategories[0].id);
          } else {
            getStoresOfCategory(categories[0].id);
          }
        }
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

  ///// get store category slides
  getStoreCategorySlide() async {
    print(11111111111);
    isCategorySlidesLoading = true;
    update();
    Either<Failure, List<CategorySlide>> result = await getStoreCategorySlidesUsecase();
    result.fold((Failure failure) {
      isCategorySlidesLoading = false;
      update();
      AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
    }, (List<CategorySlide> slides) {
      isCategorySlidesLoading = false;
      categorySlides = slides;
      update();
      print(slides);
    });
  }
}
