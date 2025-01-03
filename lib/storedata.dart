import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class store extends StatefulWidget {
  const store({super.key});

  @override
  State<store> createState() => _storeState();
}

class _storeState extends State<store> {
  TextEditingController nameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController professionController = TextEditingController();

  final CollectionReference myItems = FirebaseFirestore.instance.collection("Store Data");

  Future <void> storeData() async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return myDialogBox(context: context,onPressed: () {
            String name = nameController.text;
            String address = addressController.text;
            String profession = professionController.text;
            myItems.add(
              {
                'name':name,
                'address':address,
                'profession':profession,

              });
            Navigator.pop(context);

          });

    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Store Data Successfully",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: storeData,
          backgroundColor: Colors.deepPurpleAccent.shade400,
          child: Icon(Icons.add,color: Colors.white),

      ),
    );
  }
  Dialog myDialogBox({
  required BuildContext context,
  required VoidCallback onPressed,
  })
  {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Store data from user',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  ),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],
              ),

              commonTextField("eg. Aman","Enter Your Name",nameController),
              commonTextField("eg. Surat","Enter Your Address",addressController),
              commonTextField("eg. Developer","Enter Your Profession",professionController),
              
              ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                  child: const Text("Submitted",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
  Padding commonTextField(hint,label,controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      ),
    );
  }
}
