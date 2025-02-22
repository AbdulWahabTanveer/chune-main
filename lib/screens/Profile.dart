//To God be the Glory

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/Useful_Code/constants.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/core/bloc/follow_card/follow_card_bloc.dart';
import 'package:newapp/models/chune.dart';
import 'package:newapp/models/profile_model.dart';
import 'package:newapp/screens/UserScreens/LikedChunes.dart';
import 'package:newapp/screens/Widgets/FollowCard.dart';
import 'package:newapp/screens/Widgets/player_panel.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../Useful_Code/app_cubits.dart';
import '../Useful_Code/ids_list/ids_list_check_view.dart';
import '../Useful_Code/widgets.dart';
import '../auth_flow/app/bloc/app_bloc.dart';
import '../core/bloc/report_cubit.dart';
import '../core/bloc/user_profile/user_profile_bloc.dart';
import '../repositories/profile_repository.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen(
    this.userId, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc()..add(LoadUserProfileEvent(userId)),
      child: _UserProfileContent(),
    );
  }
}

class _UserProfileContent extends StatefulWidget {
  @override
  __UserProfileState createState() => __UserProfileState();
}

class __UserProfileState extends State<_UserProfileContent> {
  ///Variables for the followers count
  int followersCount = 0;
  int followingCount = 0;
  int chuneCount = 0;
  bool following = false;

  @override
  Widget build(BuildContext context) {
    // return HomePageFromSample();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'chune',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileLoadedState) {
                  final profile = state.profile;
                  final myId = context.read<AppBloc>().state.user.id;

                  return BlocProvider(
                    create: (context) =>
                        FollowCardBloc()..add(LoadFollowCard(profile)),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(height: 30),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                  disabledColor: Colors.white,
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.transparent,
                                  ),
                                  onPressed: null,
                                ),
                                AvatarImage(
                                  profile.image,
                                  35,
                                ),
                                CupertinoButton(
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: mainButtomSheetShape,
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (context) =>
                                          _UserProfileActions(profile: profile),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              '@${profile.username}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Builder(builder: (context) {
                            return BlocBuilder<FollowCardBloc, FollowCardState>(
                              builder: (context, state) {
                                if (state is FollowCardLoaded) {
                                  final profile = state.card;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: GestureDetector(
                                          child: Row(
                                            children: [
                                              Text(
                                                '${profile.chunesShared ?? 0}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Chunes',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          child: Row(
                                            children: [
                                              Text(
                                                '${profile.followersCount ?? 0}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Followers',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          child: Row(
                                            children: [
                                              Text(
                                                '${profile.followingCount ?? 0}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Following',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return loader();
                              },
                            );
                          }),
                        ),
                        if (myId != profile.id) SizedBox(height: 20),
                        if (myId != profile.id)
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(100),
                                    ),
                                  ),
                                  child: _FollowButton(
                                    card: profile,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 20),
                        _ChuneList(profile.id)
                      ]),
                    ),
                  );
                }
                if (state is UserProfileErrorState) {
                  return Text("${state.error}");
                }
                return loader();
              },
            ),
          ),
          PlayerPanel()
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final ProfileModel card;

  const _FollowButton({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCardBloc, FollowCardState>(
      builder: (context, state) {
        if (state is FollowCardLoaded) {
          return TextButton(
            child: Text(
                state.card.isFollowing ?? false ? 'Following' : 'Follow',
                style: TextStyle(fontSize: 21, color: Colors.blue)),
            onPressed: () {
              context.read<FollowCardBloc>().add(FollowUserEvent(state.card));
            },
          );
        }
        return loader();
      },
    );
  }
}

class _ChuneList extends StatelessWidget {
  final String id;

  _ChuneList(this.id);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: PaginateFirestore(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, documentSnapshots, index) {
            final chune = Chune.fromMap(documentSnapshots[index].data() as Map)
                .copyWith(id: documentSnapshots[index].id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: ChuneRow(chune,
                  chunes: List<Chune>.from(documentSnapshots.map((e) =>
                      Chune.fromMap(e.data() as Map).copyWith(id: e.id)))),
            );
          },
          itemBuilderType: PaginateBuilderType.listView,
          query: GetIt.I.get<ProfileRepository>().userChunesQuery(id),
        ));
  }
}

class _UserProfileActions extends StatefulWidget {
  const _UserProfileActions({
    Key key,
    this.profile,
  }) : super(key: key);

  final ProfileModel profile;

  @override
  State<_UserProfileActions> createState() => _UserProfileActionsState();
}

class _UserProfileActionsState extends State<_UserProfileActions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const HeightSpace(),
        const buttomSheetHeader(),
        const HeightSpace(20),
        IDsCheck(
          onSuccess: (isAdd) {
            if (mounted) {
              Navigator.pop(context);
            }
            return isAdd
                ? 'Blocked @${widget.profile.username} successfully'
                : 'Unblocked @${widget.profile.username} successfully';
          },
          cubit: AppCubits.mutedUsersCubit,
          id: widget.profile.id,
          builder: (isAdded) => ListTile(
            leading: isAdded
                ? Icon(Icons.volume_up_rounded)
                : Icon(Icons.volume_off_rounded),
            title: MText(
              '${isAdded ? 'Unblock' : 'Block'} @${widget.profile.username}',
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.flag_outlined),
          title: MText('Report this user'),
          onTap: () async {
            final userId = context.read<AppBloc>().state.user.id;

            final result = await context
                .read<ReportCubit>()
                .reportUser(reportedUserId: widget.profile.id, myID: userId);
            if (result) {
              if (mounted) {
                Navigator.pop(context);
              }
              Fluttertoast.showToast(
                msg: 'Reported successfully',
              );
            } else {
              Fluttertoast.showToast(
                msg: 'something went worng',
              );
            }
          },
        ),
        HeightSpace(),
      ],
    );
  }
}
