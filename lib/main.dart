import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool changebut1 = false;
  bool changebut2 = false;
  bool changebut3 = false;
  late String studentname, studentid, studentprogram;
  late double studentGPA;

  getstudentname(name) {
    this.studentname = name;
  }

  getstudentid(id) {
    this.studentid = id;
  }

  getstudentprogram(program) {
    this.studentprogram = program;
  }

  getstudentGPA(GPA) {
    this.studentGPA = double.parse(GPA);
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Park").doc(studentname);
    // creating map
    Map<String, dynamic> students = {
      "studentname": studentname,
      "studentid": studentid,
      "studentprogram": studentprogram,
      "studentGPA": studentGPA
    };
    documentReference
        .set(students)
        .whenComplete(() => {print("$studentname created")});
    changebut1 = false;
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Park").doc(studentname);
    // creating map
    Map<String, dynamic> students = {
      "studentname": studentname,
      "studentid": studentid,
      "studentprogram": studentprogram,
      "studentGPA": studentGPA
    };
    documentReference
        .set(students)
        .whenComplete(() => {print("$studentname update")});
    changebut2 = false;
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Park").doc(studentname);

    documentReference
        .delete()
        .whenComplete(() => {print("$studentname deleted")});
    changebut3 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MY flutter college"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    )),
                onChanged: (String name) {
                  getstudentname(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    )),
                onChanged: (String id) {
                  getstudentid(id);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student Program",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    )),
                onChanged: (String program) {
                  getstudentprogram(program);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    )),
                onChanged: (String GPA) {
                  getstudentGPA(GPA);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    createData();
                    setState(() {
                      changebut1 = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 80,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Create",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: changebut1
                            ? const Color.fromARGB(77, 39, 34, 34)
                            : Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      deleteData();
                      changebut2 = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 80,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: changebut2
                            ? Color.fromARGB(77, 39, 34, 34)
                            : Colors.red),
                  ),
                ),
                InkWell(
                  onTap: () {
                    updateData();
                    setState(() {
                      changebut3 = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 80,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: changebut3
                            ? Color.fromARGB(77, 39, 34, 34)
                            : Colors.green),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
