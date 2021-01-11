import 'package:food_cafe/model/kdsview/KDSView.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class KDSViewController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  RxList<KDSView> rxKDSViewList;

  @override
  onInit() {
    super.onInit();
    fetchKDSView();
  }

  Future<void> fetchKDSView() async {
    stateStatus.value = StateStatus.LOADING;

    var kdsViewResponse = KDSViewResponse(kdsViewList: [
      KDSView(
          id: '001', menuName: 'Chicken biryaani', stockCounter: 12, isPause: false)
    ]);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    rxKDSViewList = kdsViewResponse.kdsViewList.obs;
  }
}
