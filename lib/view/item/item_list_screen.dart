import '../../../view_model/item_cubit/item_cubit_view_model.dart';
import '../../../view_model/item_cubit/item_state_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_detail_screen.dart';


class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ItemCubit>().fetchItem();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item List"),automaticallyImplyLeading: false,),
      body: BlocConsumer<ItemCubit,ItemCubitState>(
    listener: (context, state) {
      if (state is ItemError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,),
        );
      }
      if (state is ItemLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item Fetched successfully",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
        );
      }
    },
        builder: (context, state) {
          if(state is ItemLoading){
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is ItemLoaded){
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4),
              itemCount: state.itemList.length,
              itemBuilder: (context, index) {
                final listData = state.itemList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailScreen(title: listData.title, description: listData.body),));
                  },
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // color: Color(0xff090979),
                        gradient: const LinearGradient(
                          colors: [Color(0xff020024), Color(0xff090979),Color(0xff00d4ff)],
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
                          const Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 10,),
                          Text(listData.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 20,),
                          const Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
                          const SizedBox(height: 10,),
                          Expanded(child: Text(listData.body,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),overflow: TextOverflow.ellipsis,)),
                        ],
                      )
                  ),
                );
              },
            );
          }
          else if(state is ItemError){
            return Text(state.error);
          }
          return Container();
        },
   ));
  }
}
