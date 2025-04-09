import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/database/database_repository.dart';
import '../../model/add_item_model.dart';
import '../../utils/common_toast.dart';
import '../../view_model/add_item_cubit/add_item_cubit_viewmodel.dart';

class EditItemScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;

  const EditItemScreen({super.key, required this.id, required this.title, required this.description});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }
  @override
  Widget build(BuildContext context) {
    final repository =context.read<DatabaseRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter Title",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5)
                  )
              ),

            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5)
                  )
              ),
            ),
          ),
          const SizedBox(height: 30,),
          GestureDetector(
            onTap: () async{
              if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                ItemModel item = ItemModel(title: titleController.text, description: descriptionController.text,id: widget.id);
                await repository.updateItem(item).then((value) {
                  CommonToast.SuccessToast("Item Updated Successfully..");
                  context.read<AddItemCubit>().fetchDataItem();
                  Navigator.pop(context);
                },);
              }else{
                CommonToast.WarnignToast("All Field Required");
              }
            },
            child: Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.all(8),
              alignment: Alignment.center,
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
              child: const Text("Update Item",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
