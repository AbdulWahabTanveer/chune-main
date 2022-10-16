import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // List chuneList;

  @override
  void initState() {
    super.initState();
    // chuneList = <Chune>[];
  }

  Widget build(BuildContext context) {
    return BlocConsumer<ShareAChuneBloc, ShareAChuneState>(
      listener: (context, state) {
        if (state is ChuneShareSuccessState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
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
                              enabled: state is! ChunesLoadingState,
                              onSubmitted: (String chune) {
                                context
                                    .read<ShareAChuneBloc>()
                                    .add(SearchChuneEvent(chune));
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Enter artists & songs...',
                                focusColor: Colors.grey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
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
            child: Column(
              children: [
                SizedBox(height: 20),
                if (state is ChunesLoadSuccess)
                  SingleChildScrollView(
                    child: SizedBox(
                      // height: h * 3,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.chunes.length,
                        itemBuilder: (context, index) {
                          final chune = state.chunes[index];
                          return ChuneRow(chune, () => isSelected(chune),
                              selectedChune?.playUri == chune.playUri);
                        },
                      ),
                    ),
                  ),
                if (state is ChunesLoadingState) loader()
              ],
            ),
          ),
          floatingActionButton: state is ChuneSharingState
              ? loader()
              : FloatingActionButton(
                  onPressed: selectedChune == null
                      ? null
                      : () {
                          context
                              .read<ShareAChuneBloc>()
                              .add(ShareChuneEvent(selectedChune,context.read<AppBloc>().state.user));
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
        // chune.isSelected ? selectedCounter++ : selectedCounter--;
        // print(selectedCounter);
        //
        // selectedCounter >= 1
        //     ? selectedColor = Colors.blue
        //     : selectedColor = Colors.grey;
      },
    );
    // var _musicKitPlugin = MusicKit();
    // await _musicKitPlugin.setQueue('songs',
    //     item:  {
    //       "id": "1130322151",
    //       "type": "songs",
    //       "href": "/v1/catalog/in/songs/1130322151",
    //       "attributes": {
    //         "albumName": "Dil Se (Original Motion Picture Soundtrack)",
    //         "genreNames": [
    //           "Bollywood",
    //           "Music",
    //           "Indian",
    //           "Soundtrack"
    //         ],
    //         "trackNumber": 1,
    //         "releaseDate": "1998-07-08",
    //         "durationInMillis": 416613,
    //         "isrc": "INV119800029",
    //         "artwork": {
    //           "width": 1440,
    //           "height": 1440,
    //           "url": "https://is5-ssl.mzstatic.com/image/thumb/Music114/v4/8e/f8/85/8ef88544-a6c7-018b-0a75-dc3b6b024fa0/cover.jpg/{w}x{h}bb.jpg",
    //           "bgColor": "011106",
    //           "textColor1": "fd960c",
    //           "textColor2": "f17603",
    //           "textColor3": "ca7b0a",
    //           "textColor4": "c16103"
    //         },
    //         "composerName": "A.R. Rahman & Gulzar",
    //         "url": "https://music.apple.com/in/album/chaiyya-chaiyya/1130322055?i=1130322151",
    //         "playParams": {
    //           "id": "1130322151",
    //           "kind": "song"
    //         },
    //         "discNumber": 1,
    //         "hasLyrics": true,
    //         "isAppleDigitalMaster": false,
    //         "name": "Chaiyya Chaiyya",
    //         "previews": [
    //           {
    //             "url": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/34/3d/b9/343db955-51de-a7aa-c355-649133ca840e/mzaf_18166352209998766749.plus.aac.p.m4a"
    //           }
    //         ],
    //         "artistName": "Sukhwinder Singh & Sapna Awasthi"
    //       }
    //     });
    // await _musicKitPlugin.play();
    // return;
    context.read<MusicPlayerBloc>().add(SetAudioEvent(chune));
  }
}

class ChuneRow extends StatelessWidget {
  final bool isSelected;

  ChuneRow(this.chune, this.onSelect, this.isSelected);

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
