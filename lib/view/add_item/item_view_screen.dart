import '../../../view_model/add_item_cubit/add_item_cubit_viewmodel.dart';
import '../../../view_model/add_item_cubit/add_item_state_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/database_repository.dart';
import '../../utils/common_toast.dart';
import 'package:provider/provider.dart';

import '../item/item_detail_screen.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class ItemViewScreen extends StatefulWidget {
  const ItemViewScreen({super.key});

  @override
  State<ItemViewScreen> createState() => _ItemViewScreenState();
}

class _ItemViewScreenState extends State<ItemViewScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AddItemCubit>().fetchDataItem();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Item View")),
      body: BlocConsumer<AddItemCubit,AddItemCubitState>(
        listener: (context, state) {
          if (state is AddItemErro) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,),
            );
          }
          if (state is AddItemLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item Fetched successfully",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
            );
          }
        },
          builder: (context, state) {
            if(state is AddItemLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is AddItemLoaded){
              return state.itemModel.isNotEmpty?GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.6,
                ),
                itemCount: state.itemModel.length,
                itemBuilder: (context, index) {
                  final listData = state.itemModel[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ItemDetailScreen(
                            title: listData.title,
                            description: listData.description,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // color: Color(0xff090979),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff020024),
                            Color(0xff090979),
                            Color(0xff00d4ff),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => EditItemScreen(
                                            id: listData.id!,
                                            title: listData.title,
                                            description:
                                            listData.description,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  GestureDetector(
                                    onTap: () {
                                      deleteAccount(listData.id!);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            listData.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              listData.description,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ): const Center(
                child: Text(
                  "No data available",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            else if(state is AddItemErro){
              return Text(state.error);
            }
            return Container();
          },
         ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void deleteAccount(int id) {
    final repository =context.read<DatabaseRepository>();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Delete Item",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: const Text("Are you sure want to delete this item?"),
            actions: [
              MaterialButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minWidth: 80,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    repository.deleteItem(id);
                    context.read<AddItemCubit>().fetchDataItem();
                    CommonToast.SuccessToast("Item Deleted Successfully..");
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
