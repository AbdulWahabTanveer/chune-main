import 'package:flutter/material.dart';
import 'package:newapp/screens/Profile.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/globalvariables.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../models/profile_model.dart';
import 'UserScreens/Userprofile.dart';
import '../../repositories/home_page_repo.dart';
import 'package:get_it/get_it.dart';

class ViewAllAccounts extends StatefulWidget {
  @override
  _ViewAllAccounts createState() => _ViewAllAccounts();
}

class _ViewAllAccounts extends State<ViewAllAccounts> {
  final repo = GetIt.I.get<HomePageRepository>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            SizedBox(width: 24,)
          ],
          backgroundColor: Colors.white,
          elevation: 1,
          toolbarHeight: 70,
          title: Center(
            child: Text(
              'chune',
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            PaginateFirestore(
              shrinkWrap: true,
              itemBuilder: (context, documentSnapshots, index) {
                var e = documentSnapshots[index];
                final profile =
                    ProfileModel.fromMap(e.data()).copyWith(id: e.id);
                return FollowCard(
                  profile,
                  () => isFollowing(index),
                );
              },
              query: repo.allUserAccountsQuery,
              itemBuilderType: PaginateBuilderType.listView,
            )
          ],
        ));
  }

  isFollowing(int index) {}

}
