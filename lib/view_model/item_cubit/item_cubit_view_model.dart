import '../../../data/api/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/item_list_model.dart';
import 'item_state_view_model.dart';

class ItemCubit extends Cubit<ItemCubitState> {
  final ApiService apiService;
  final List<ItemListModel> _itemList = [];
  ItemCubit(this.apiService) : super(ItemInitial());

  Future<void> fetchItem() async {
    emit(ItemLoading());
    try{
      final response = await apiService.getApiData();
      response.forEach((data){
        _itemList.add(ItemListModel.fromJson(data));
      });
      emit(ItemLoaded(_itemList));
    }
    catch(e){
      emit(ItemError(e.toString()));
    }
  }
}