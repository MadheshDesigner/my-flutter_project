import '../../model/add_item_model.dart';

abstract class AddItemCubitState {}

class AddItemInitial extends AddItemCubitState{}
class AddItemLoading extends AddItemCubitState{}
class AddItemLoaded extends AddItemCubitState{
  final List<ItemModel> itemModel;
  AddItemLoaded(this.itemModel);
}

class AddItemErro extends AddItemCubitState{
  final String error;
  AddItemErro(this.error);
}