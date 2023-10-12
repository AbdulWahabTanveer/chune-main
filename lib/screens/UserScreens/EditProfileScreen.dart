import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Useful_Code/constants.dart';
import '../../Useful_Code/widgets.dart';
import '../Player.dart';
import 'ChangeUsername.dart';
import 'UploadProfilePhoto.dart';
import '../globalvariables.dart';
import 'LikedChunes.dart';

import '../../auth_flow/app/bloc/app_bloc.dart';
import 'manage_account.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     child: Icon(
      //       Icons.arrow_back,
      //       color: Colors.blueGrey,
      //     ),
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   centerTitle: true,
      //   toolbarHeight: 70,
      //   title: Text(
      //     'chune',
      //     style: TextStyle(
      //         color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
      //   ),
      // ),
      body: Column(children: [
        InkWell(
          splashColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LikedChunes()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Liked chunes'),
                Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeUsername()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Change username'),
                Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadProfilePhoto()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upload profile photo'),
                Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.white,
          onTap: () {
  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageAccount()),
              );
                      },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Manage Account'),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
          ),
        ),
      ]),
    );
  }

  showConfirm(BuildContext context, VoidCallback onConfirm) {
    showModalBottomSheet(
                                      shape: mainButtomSheetShape,
    backgroundColor: Colors.white,

      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeightSpace(),
          const buttomSheetHeader(),
          const HeightSpace(40),
          Text('Sure you want to Delete your account? 🙁'),
          ListTile(
            title: Text(
              'Yes',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: Icon(
              Icons.check,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
          ListTile(
            title: Text(
              'No, cancel',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: Icon(
              Icons.close,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const HeightSpace(40),
        ],
      ),
    );
  }

}
