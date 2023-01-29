import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';
import 'package:jdolh_flutter/store/domain/entities/product_category.dart';
import 'package:jdolh_flutter/store/domain/entities/product_details.dart';
import 'package:jdolh_flutter/store/domain/entities/store_details.dart';
import 'package:jdolh_flutter/store/domain/usecases/get_product_details_usecase.dart';
import 'package:jdolh_flutter/store/domain/usecases/get_store_details_usecase.dart';
import 'package:jdolh_flutter/store/domain/usecases/get_store_product_categories_usecase.dart';

class StoreController extends GetxController {
  final GetStoreDetailsUsecase getStoreDetailsUsecase;
  final GetStoreProductCategoryUsecase getStoreProductCategoryUsecase;
  final GetProductDetailsUsecase getProductDetailsUsecase;
  StoreController(this.getStoreDetailsUsecase, this.getStoreProductCategoryUsecase, this.getProductDetailsUsecase);

  ///// variables
  StoreDetails? storeDetails;
  ProductDetails? productDetails;
  List<ProductCategory> storeProductCategories = [];
  bool isGetStoreDetailsLoading = false;
  bool isGetStoreProductCategoriesLoading = false;
  bool isGetProductDetailsLoading = false;

  ///// get store details
  getStoreDetails(int storeId) async {
    isGetStoreDetailsLoading = true;
    update();
    getStoreProductCategories(storeId);
    Either<Failure, StoreDetails> result = await getStoreDetailsUsecase(storeId);
    result.fold(
      (Failure failure) {
        isGetStoreDetailsLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
      },
      (StoreDetails details) {
        isGetStoreDetailsLoading = false;
        storeDetails = details;
        update();
        print(storeDetails);
      },
    );
  }

  ///// get store product categories
  getStoreProductCategories(int storeId) async {
    isGetStoreProductCategoriesLoading = true;
    update();

    Either<Failure, List<ProductCategory>> result = await getStoreProductCategoryUsecase(storeId);
    result.fold(
      (Failure failure) {
        isGetStoreProductCategoriesLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
      },
      (List<ProductCategory> productCategories) {
        isGetStoreProductCategoriesLoading = false;
        storeProductCategories = productCategories;
        update();
        print(productCategories);
      },
    );
  }

  ///// get product details
  getProductDetails(int productId) async {
    isGetProductDetailsLoading = true;
    update();
    Either<Failure, ProductDetails> result = await getProductDetailsUsecase(productId);
    result.fold(
      (Failure failure) {
        isGetProductDetailsLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة أخرى');
      },
      (ProductDetails details) {
        isGetProductDetailsLoading = false;
        productDetails = details;
        update();
      },
    );
  }
}
