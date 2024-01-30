import 'package:flutter/material.dart';
import 'package:flutter_list/userdata.dart';
import 'package:flutter_list/useritem.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController nama = new TextEditingController();
  TextEditingController umur = new TextEditingController();
  TextEditingController email = new TextEditingController();

  List<UserData> daftarUser = [
    UserData("Umam", 22, "miftahulumam862@gmail.com"),
    UserData("Jonatan", 26, "jonatan@gmail.com"),
    UserData("Ardian", 25, "ardian@gmail.com"),
  ];

  String btnSimpanText = "Simpan";
  String btnUbahText = "Ubah";
  Color btnSimpanWarna = Colors.blue;
  Color btnUbahWarna = Colors.blueGrey;

  int indexDipilih = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: nama,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: umur,
                  decoration: InputDecoration(
                    labelText: "Umur",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  try {
                    if (nama.text.isEmpty ||
                        umur.text.isEmpty ||
                        email.text.isEmpty) {
                      throw new Exception("Isian Tidak Boleh Kosong");
                    }
                    if (btnSimpanText == "Simpan") {
                      // Menambahkan record sebanyak jumlah umur
                      for (int i = 0; i < int.parse(umur.text); i++) {
                        daftarUser.add(UserData("${i + 1}. ${nama.text}",
                            int.parse(umur.text), email.text));
                      }
                    } else {
                      UserData userData = daftarUser[indexDipilih];
                      userData.nama = nama.text;
                      userData.umur = int.parse(umur.text);
                      userData.email = email.text;

                      btnSimpanText = "Simpan";
                    }
                    setState(() {
                      daftarUser;
                    });
                    nama.text = "";
                    umur.text = "";
                    email.text = "";
                  } catch (e) {
                    Fluttertoast.showToast(msg: '$e');
                  }
                },
                child: Text(btnSimpanText),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 75),
                    backgroundColor: btnSimpanWarna),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(daftarUser.toString()),
                      child: InkWell(
                        child: UserItem(daftarUser[index]),
                        onTap: () {
                          nama.text = daftarUser[index].nama;
                          umur.text = daftarUser[index].umur.toString();
                          email.text = daftarUser[index].email;

                          btnSimpanText = btnUbahText;
                          btnSimpanWarna = btnUbahWarna;

                          indexDipilih = index;

                          setState(() {
                            btnSimpanText;
                            btnSimpanWarna;
                          });
                        },
                      ),
                      background: Container(
                        padding: EdgeInsets.only(left: 10),
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.only(left: 10),
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          daftarUser.removeAt(index);
                          setState(() {
                            daftarUser;
                          });
                        }
                        inspect(daftarUser);
                      },
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content:
                                  const Text("Apakah yakin akan menghapus"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Hapus"),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("Batal"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: daftarUser.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
