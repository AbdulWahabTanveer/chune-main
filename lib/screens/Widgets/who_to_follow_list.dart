import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/Useful_Code/utils.dart';
import 'package:newapp/core/bloc/who_to_follow/who_to_follow_bloc.dart';

import '../ViewAllAccounts.dart';
import 'FollowCard.dart';

class WhoToFollowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WhoToFollowBloc()..add(LoadWhoToFollowEvent()),
      child: _WhoToFollowContent(),
    );
  }
}

class _WhoToFollowContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WhoToFollowBloc>();
    return BlocBuilder<WhoToFollowBloc, WhoToFollowState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is WhoToFollowSuccessState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllAccounts(),
                          ),
                        ).then((value) {
                          // bloc.add(LoadWhoToFollowEvent());
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 350,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics:const BouncingScrollPhysics(),
                  child: Row(
                    // physics:const BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    // itemCount: state.users.length,
                    // itemBuilder: (context, index) {
                      /*return*/
                        children: [
                          for(final i in state.users)
                          FollowCard(i
                            // state.users[index],
                          ),
                        ],
                      //;
                    // },
                  ),
                ),
              ),
            ],
          );
        }
        if (state is WhoToFollowErrorState) {
          return ErrorWidget(state.error);
        }
        return loader();
      },
    );
  }

  isFollowing(int index) {}
}
