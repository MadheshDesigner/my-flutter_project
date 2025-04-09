import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/database_repository.dart';
import '../../model/add_item_model.dart';
import 'add_item_state_viewmodel.dart';

class AddItemCubit extends Cubit<AddItemCubitState>{
  final DatabaseRepository repository;

  AddItemCubit(this.repository):super(AddItemInitial());

  Future<void> fetchDataItem()async{
    emit(AddItemLoading());
    Future.delayed(const Duration(seconds: 1));
    try{
      List<ItemModel> _itemModel = await repository.getItem();
      emit(AddItemLoaded(_itemModel));
    }
    catch(e){
      emit(AddItemErro(e.toString()));
    }
  }
}