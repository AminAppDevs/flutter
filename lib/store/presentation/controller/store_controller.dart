import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';
import 'package:jdolh_flutter/store/domain/entities/store_details.dart';
import 'package:jdolh_flutter/store/domain/usecases/get_store_details_usecase.dart';

class StoreController extends GetxController {
  final GetStoreDetailsUsecase getStoreDetailsUsecase;
  StoreController(this.getStoreDetailsUsecase);

  ///// variables
  StoreDetails? storeDetails;
  bool isGetStoreDetailsLoading = false;

  ///// get store details
  getStoreDetails(int storeId) async {
    isGetStoreDetailsLoading = true;
    update();
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
}
