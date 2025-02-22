import 'package:flutter/material.dart';
import 'Profile.dart';
import 'Widgets/FollowCard.dart';
import 'globalvariables.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../models/profile_model.dart';
// import 'UserScreens/Userprofile.dart';
import '../../repositories/home_page_repo.dart';
import 'package:get_it/get_it.dart';

class ViewAllAccounts extends StatefulWidget {
  @override
  _ViewAllAccounts createState() => _ViewAllAccounts();
}

class _ViewAllAccounts extends State<ViewAllAccounts> {
  final repo = GetIt.I.get<HomePageRepository>();

  final c = ScrollController();

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
          SizedBox(
            width: 24,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body:
      SingleChildScrollView(
        controller: c,
        child:
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: PaginateFirestore(
            scrollController: c,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, documentSnapshots, index) {
              var e = documentSnapshots[index];
              final profile = ProfileModel.fromMap(e.data()).copyWith(id: e.id);
              return FollowCard(
                profile,
              );
            },
            query: repo.allUserAccountsQuery,
            itemBuilderType: PaginateBuilderType.listView,
          ),
        ),
      ),
    );
  }

  isFollowing(int index) {}
}
