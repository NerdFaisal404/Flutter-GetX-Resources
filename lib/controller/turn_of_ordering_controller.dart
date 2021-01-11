import 'package:food_cafe/model/turn_of_ordering/turn_of_ordering_response.dart';
import 'package:food_cafe/utils/state_status.dart';
import 'package:get/get.dart';

class TurnOfOrderingController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var turnOfOrderingResponse = Rx<TurnOfOrderingResponse>();

  Future<void> callTurnOfOrdering() async {
    stateStatus.value = StateStatus.LOADING;
    TurnOfOrderingResponse turnOfOrderingResponse =  TurnOfOrderingResponse(turnOfOrderingList: [
      TurnOfOrdering(userId: '1', userName: 'Lakhani Kamlesh', recipeName: 'Chicken biryani', dateTime: '11-7-2020 - 1:15 PM', availableRecipe: '20-12-2020 - 1:15 PM'),
      TurnOfOrdering(userId: '2', userName: 'Lakhani Kamlesh', recipeName: 'Chicken biryani', dateTime: '11-8-2020 - 1:15 PM', availableRecipe: '20-12-2020 - 1:15 PM'),
    ]);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;

    this.turnOfOrderingResponse.value = turnOfOrderingResponse;
  }
}