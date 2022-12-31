import 'dart:convert';

import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/server_error_model.dart';
import 'package:jdolh_flutter/core/utils/api_config.dart';
import 'package:jdolh_flutter/store/data/datasource/base_remote_store_datasource.dart';
import 'package:jdolh_flutter/store/data/model/store_details_model.dart';
import 'package:http/http.dart' as http;

class RemoteStoreDatasource extends BaseRemoteStoreDatasource {
  ///// get store details
  @override
  Future<StoreDetailsModel> getStoreDetails(int storeId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getStoreDetails}/$storeId';
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return StoreDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
