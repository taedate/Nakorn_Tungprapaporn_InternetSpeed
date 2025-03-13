import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakorn_tungprapaporn/addForm.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nakorn_tungprapaporn/updateForm.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    CollectionReference internetRef =
        FirebaseFirestore.instance.collection('InternetSpeed');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFA31D1D),
        leading: Icon(Icons.wifi_tethering, color: Colors.white,),
        title: Text('INTERNET SPEED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 55),
                  child: Text(
                    'User name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text('Speed',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Icon(Icons.speed),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
                stream: internetRef.snapshots(),
                builder: (context, snapshot) {
                  var internetSnapsot = snapshot.data!.docs;
                  if (!snapshot.hasData|| snapshot.data!.docs.isEmpty) return Center(child: Text('No data Internet Speed !'));
                  return ListView.builder(
                      itemCount: internetSnapsot.length,
                      itemBuilder: (context, index) {
                        var internetIndex = internetSnapsot[index];
                        var indexId = index + 1;
                        return Column(
                          children: [
                            Slidable(
                              endActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Updateform(),
                                              settings: RouteSettings(
                                                  arguments: internetIndex)));
                                    },
                                    icon: Icons.edit,         
                                    // foregroundColor: Colors.white,                           
                                    backgroundColor: Color(0xFFECDCBF),
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDeleteConfirmation(
                                          context, internetIndex.id);
                                    },
                                    icon: Icons.delete,
                                    backgroundColor: Color(0xFFA31D1D),
                                  )
                                ],
                              ),
                              child: ListTile(
                                leading: Text(indexId.toString()),
                                title: Text(internetIndex['userName']),
                                trailing: Text(internetIndex['speed'] + ' (Mbps)',
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                              ),
                              
                            ),
                            Divider(height: 1, thickness: 1,),
                          ],
                        );
                      });
                }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFA31D1D),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addform()));
          setState(() {});
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

void showDeleteConfirmation(BuildContext context, String docId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {      
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('ยืนยันการลบ'),
        content: const Text('คุณแน่ใจหรือไม่ว่าจะลบข้อมูลนี้?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('InternetSpeed')
                  .doc(docId)
                  .delete();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('ลบเลย'),
          ),
        ],
      );
    },
  );
}
