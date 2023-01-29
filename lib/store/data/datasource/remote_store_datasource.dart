import 'dart:convert';
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/server_error_model.dart';
import 'package:jdolh_flutter/core/utils/api_config.dart';
import 'package:jdolh_flutter/store/data/datasource/base_remote_store_datasource.dart';
import 'package:jdolh_flutter/store/data/model/product_category_model.dart';
import 'package:jdolh_flutter/store/data/model/product_details_model.dart';
import 'package:jdolh_flutter/store/data/model/store_details_model.dart';
import 'package:http/http.dart' as http;

class RemoteStoreDatasource extends BaseRemoteStoreDatasource {
  ///// get store details
  @override
  Future<StoreDetailsModel> getStoreDetails(int storeId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getStoreDetails}/$storeId';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return StoreDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// get store product categories
  @override
  Future<List<ProductCategoryModel>> getStoreProductCategories(int storeId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getStoreProductCategories}/$storeId';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => ProductCategoryModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getStoreProductDetails}/$productId';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ProductDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
