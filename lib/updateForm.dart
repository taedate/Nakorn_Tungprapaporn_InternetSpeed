import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updateform extends StatefulWidget {
  Updateform({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  State<Updateform> createState() => _UpdateformState();
}

class _UpdateformState extends State<Updateform> {
  CollectionReference internetRef =
      FirebaseFirestore.instance.collection('InternetSpeed');

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as dynamic;
    final providerController =
        TextEditingController(text: userData['provider']);
    final speedController = TextEditingController(text: userData['speed']);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFA31D1D),
          title: Text('Update Internet Infomation',
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
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: providerController,
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
                            controller: speedController,
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
                      height: 25,
                    ),
                    Container(
                      width: 370,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black.withOpacity(1),
                            elevation: 10,
                            backgroundColor: Color(0xFFA31D1D),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            if (widget._formKey.currentState!.validate()) {
                              internetRef.doc(userData.id).update({
                                'provider': providerController.text,
                                'speed': speedController.text,
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text('ยินยัน',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                ))));
  }
}
