import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/components/app_title.dart';

class UserListRow extends StatelessWidget {
  final String userModel;
  final Function onTap;

  UserListRow({this.userModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //used to perform action
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppTitle(title: userModel),
            Text(
              userModel,
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
