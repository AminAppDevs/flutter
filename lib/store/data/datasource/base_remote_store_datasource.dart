import 'package:jdolh_flutter/store/data/model/store_details_model.dart';

abstract class BaseRemoteStoreDatasource {
  Future<StoreDetailsModel> getStoreDetails(int storeId);
}
