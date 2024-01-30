import 'package:flutter/material.dart';
import 'package:flutter_list/userdata.dart';

class UserItem extends StatelessWidget {
  UserData userData;
  UserItem(this.userData);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Text(userData.nama[0].toUpperCase(),
              style: TextStyle(color: Colors.white)),
        ),
        Container(
          padding: EdgeInsets.all(5),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userData.nama,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("umur :" +
                userData.umur.toString() +
                " " +
                "Email :" +
                userData.email),
          ],
        )
      ],
    );
  }
}
