import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addform extends StatefulWidget {
  Addform({super.key});
  final userNameController = TextEditingController();
  final providerController = TextEditingController();
  final speedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  State<Addform> createState() => _AddformState();
}

class _AddformState extends State<Addform> {
  @override
  Widget build(BuildContext context) {
    CollectionReference addInternet =
        FirebaseFirestore.instance.collection('InternetSpeed');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFA31D1D),
          title: Text('Add Internet Infomation',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(
            color: Colors.white, // เปลี่ยนสีไอคอนย้อนกลับ
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Form(
                key: widget._formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: widget.userNameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อผู้ใช้',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: widget.providerController,
                            decoration: InputDecoration(
                              labelText: 'ชื่อผู้ให้บริการ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: widget.speedController,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: 'ความเร็วดาวน์โหลด(Mbps)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 370,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black.withOpacity(1),
                          elevation: 10,
                          backgroundColor: Color(0xFFA31D1D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (widget._formKey.currentState!.validate()) {
                            addInternet.add({
                              'userName': widget.userNameController.text,
                              'provider': widget.providerController.text,
                              'speed': widget.speedController.text,
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text('บันทึก',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ))));
  }
}
