import 'package:jdolh_flutter/category/domain/entities/store.dart';

class StoreRatingSummaryModel extends StoreRatingSummary {
  const StoreRatingSummaryModel(super.id, super.rate);

  factory StoreRatingSummaryModel.fromJson(Map<String, dynamic> json) => StoreRatingSummaryModel(json['id'], json['rate']);
}
