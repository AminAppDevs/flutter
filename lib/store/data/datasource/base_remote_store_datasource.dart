import 'package:jdolh_flutter/store/data/model/product_category_model.dart';
import 'package:jdolh_flutter/store/data/model/product_details_model.dart';
import 'package:jdolh_flutter/store/data/model/store_details_model.dart';

abstract class BaseRemoteStoreDatasource {
  Future<StoreDetailsModel> getStoreDetails(int storeId);
  Future<List<ProductCategoryModel>> getStoreProductCategories(int storeId);
  Future<ProductDetailsModel> getProductDetails(int productId);
}
