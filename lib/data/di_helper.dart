import '../../../data/api/api_service.dart';
import '../../../data/database/database_connection.dart';
import '../../../data/database/database_repository.dart';
import '../../../view_model/add_item_bloc/add_item_block_logic.dart';
import '../../../view_model/add_item_cubit/add_item_cubit_viewmodel.dart';
import '../../../view_model/item_bloc/item_bloc_logic.dart';
import '../../../view_model/item_cubit/item_cubit_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DiHelper{
 static List<SingleChildWidget> providerList = [
   Provider<ApiService>(create: (context) => ApiService()),
   Provider<DatabaseConnection>(create: (context) => DatabaseConnection()),
   Provider<DatabaseRepository>(create: (context) => DatabaseRepository()),
   BlocProvider<ItemBloc>(create: (context) => ItemBloc(context.read<ApiService>())),
   BlocProvider<AddItemBloc>(create: (context) => AddItemBloc(context.read<DatabaseRepository>())),
   BlocProvider<ItemCubit>(create: (context) => ItemCubit(context.read<ApiService>())),
   BlocProvider<AddItemCubit>(create: (context) => AddItemCubit(context.read<DatabaseRepository>())),
 ];
}