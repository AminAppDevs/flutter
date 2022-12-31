import 'package:jdolh_flutter/category/data/model/category_model.dart';
import 'package:jdolh_flutter/category/data/model/category_slide_model.dart';
import 'package:jdolh_flutter/category/data/model/store_model.dart';

abstract class BaseRemoteCategoryDatasource {
  Future<List<CategoryModel>> getParentCategories();
  Future<List<CategoryModel>> getSubCategories(int categoryId);
  Future<List<StoreModel>> getStoresOfCategory(int categoryId);
  Future<List<CategorySlideModel>> getStoreCategorySlide();
}
