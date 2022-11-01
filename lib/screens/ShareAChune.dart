import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/core/bloc/profile/profile_bloc.dart';
import 'package:newapp/screens/NavScreen.dart';
import '../Useful_Code/utils.dart';
import '../auth_flow/app/bloc/app_bloc.dart';
import '../core/bloc/music_player/music_player_bloc.dart';
import '../core/bloc/share_a_chune/share_a_chune_bloc.dart';
import '../models/chune.dart';

class ShareAChune extends StatelessWidget {
  const ShareAChune({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareAChuneBloc(),
      child: _ShareAChuneContent(),
    );
  }
}

class _ShareAChuneContent extends StatefulWidget {
  @override
  _ShareAChune createState() => _ShareAChune();
}

class _ShareAChune extends State<_ShareAChuneContent> {
  // var selectedColor = Colors.grey;
  // int selectedCounter = 0;
  Chune selectedChune;
  ScrollController _controller;

  // List chuneList;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    // chuneList = <Chune>[];
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      context.read<ShareAChuneBloc>().add(SearchChuneEvent('s'));
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {}
  }

  Widget build(BuildContext context) {
    return BlocConsumer<ShareAChuneBloc, ShareAChuneState>(
      listener: (context, state) {
        if (state is ChuneShareSuccessState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var primary = Theme.of(context).primaryColor;
        var border = OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        );
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
            actions: [],
            backgroundColor: Colors.white,
            toolbarHeight: 200,
            elevation: 1,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'chune',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Share A Chune',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              cursorColor: primary,
                              style: TextStyle(color: Colors.black),
                              enabled: state is! ChunesLoadingState,
                              onSubmitted: (String chune) {
                                context
                                    .read<ShareAChuneBloc>()
                                    .add(SearchChuneEvent(chune, force: true));
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Enter artists & songs...',
                                focusColor: Colors.grey,
                                border: border,
                                focusedBorder: border,
                                enabledBorder: border,
                                focusedErrorBorder: border,
                                errorBorder: border,
                                errorStyle: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                SizedBox(height: 20),
                if (state is ChunesLoadSuccess)
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.chunes.length,
                    itemBuilder: (context, index) {
                      final chune = state.chunes[index];
                      return _ChuneRow(chune, () => isSelected(chune),
                          selectedChune?.playUri == chune.playUri);
                    },
                  ),
                if (state is ChunesLoadingState ||
                    (state is ChunesLoadSuccess && !state.end))
                  loader()
              ],
            ),
          ),
          floatingActionButton: state is ChuneSharingState
              ? loader()
              : FloatingActionButton(
                  onPressed: selectedChune == null
                      ? null
                      : () {
                          final state = context.read<ProfileBloc>().state
                              as ProfileLoadedState;
                          print("<><><><><><> PROFILE MODEL ${state.profile}");
                          context.read<ShareAChuneBloc>().add(
                              ShareChuneEvent(selectedChune, state.profile));
                        },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  backgroundColor:
                      selectedChune == null ? Colors.grey : Colors.blue),
        );
      },
    );
  }

  isSelected(Chune chune) async {
    setState(
      () {
        selectedChune = chune;
      },
    );
    context.read<MusicPlayerBloc>().add(SetAudioEvent(chune));
  }
}

class _ChuneRow extends StatelessWidget {
  final bool isSelected;

  _ChuneRow(this.chune, this.onSelect, this.isSelected);

  final Chune chune;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///SizedBox(height: 20),
            Row(
              children: [
                //SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    chune.albumArt,
                    height: 70,
                    width: 70,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chune.songName,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      chune.artistName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    onSelect();
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//
// leading: IconButton(
// onPressed: () {
// Navigator.pop(
// context,
// );
// },
// icon: Icon(
// Icons.arrow_back,
// color: Colors.black,
// ),
// ),
//
// backgroundColor: Colors.white,
// elevation: 1,
// toolbarHeight: 200,
// title: Column(
// children: [
// Center(
// child: Row(children: [
// Text(
// 'chune',
// style: TextStyle(
// color: Colors.pink,
// fontWeight: FontWeight.bold,
// fontSize: 25),
// ),
//
//
// GestureDetector(
// child: IconButton(
// icon: CircleAvatar(
// backgroundImage: AssetImage('images/wizkid.jpeg'),
// radius: 17,
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => UserProfile()),
// );
// }),
// ),
//
// ]),
// ),
// SizedBox(height: 8),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// //height: 200,
// //width: 390,
// //color: Colors.grey[50],
// child: Column(
// //TextField(),
//
// children: [
// // Container(
// //   padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
// //   child: Column(
// //     children: [
// //       Text('Share A Chune',
// //           style: TextStyle(
// //               fontSize: 35,
// //               fontWeight: FontWeight.bold)),
// //     ],
// //   ),
// // ),
// SizedBox(
// width: 350,
// child: TextField(
// onSubmitted: (String chune) {},
// decoration: InputDecoration(
// prefixIcon: Icon(Icons.search),
// hintText: 'Enter artists & songs...',
// focusColor: Colors.grey,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.all(
// Radius.circular(100),
// ),
// ),
// ),
// ),
// ),
//
// SizedBox(height: 5)
//
// //Container(height: 1, width: 390, color: Colors.blue)
// ],
// ),
// ),
// ],
// ),
// ],
// ),



