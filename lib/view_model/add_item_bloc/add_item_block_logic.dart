import '../../../data/database/database_repository.dart';
import '../../../model/add_item_model.dart';
import '../../../view_model/add_item_bloc/add_item_event.dart';
import '../../../view_model/add_item_bloc/add_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemBloc extends Bloc<AddItemEvent,AddItemState>{
  final DatabaseRepository repository;

  AddItemBloc(this.repository):super(AddItemInitial()){
    on<FetchDataItem>(_fetchDataItem);
  }

  Future<void> _fetchDataItem(AddItemEvent event, Emitter<AddItemState> emit)async{
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