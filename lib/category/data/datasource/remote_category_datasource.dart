import 'dart:convert';
import 'package:jdolh_flutter/category/data/datasource/base_remote_category_datasource.dart';
import 'package:jdolh_flutter/category/data/model/category_model.dart';
import 'package:jdolh_flutter/category/data/model/category_slide_model.dart';
import 'package:jdolh_flutter/category/data/model/store_model.dart';
import 'package:http/http.dart' as http;
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/server_error_model.dart';
import 'package:jdolh_flutter/core/utils/api_config.dart';

class RemoteCategoryDatasource extends BaseRemoteCategoryDatasource {
  ///// get parents category
  @override
  Future<List<CategoryModel>> getParentCategories() async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getParentCategories}';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// get subcategories
  @override
  Future<List<CategoryModel>> getSubCategories(int categoryId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getSubCategories}';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (response as List).map((e) => CategoryModel.fromJson(jsonDecode(response.body))).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

  ///// get stores of category
  @override
  Future<List<StoreModel>> getStoresOfCategory(int categoryId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getStoresOfCategories}/$categoryId';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => StoreModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// get store category slides
  @override
  Future<List<CategorySlideModel>> getStoreCategorySlide() async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getStoreCategorySlides}';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => CategorySlideModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
