import '../../model/item_list_model.dart';

abstract  class ItemCubitState{}

class ItemInitial extends ItemCubitState{}

class  ItemLoading extends ItemCubitState{}

class ItemLoaded extends ItemCubitState{
  final List<ItemListModel> itemList;
  ItemLoaded(this.itemList);
}

class ItemError extends ItemCubitState{
  final String error;
  ItemError(this.error);
}