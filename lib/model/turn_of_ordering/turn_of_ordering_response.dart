class TurnOfOrderingResponse{
  List<TurnOfOrdering> turnOfOrderingList;

  TurnOfOrderingResponse({this.turnOfOrderingList});
}

class TurnOfOrdering{
  String userId, userName, recipeName, dateTime, availableRecipe;

  TurnOfOrdering({this.userId, this.userName, this.recipeName, this.dateTime, this.availableRecipe});
}