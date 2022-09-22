import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:music_kit/music_kit.dart';

class ApplyApp extends StatefulWidget {
  const ApplyApp({Key key}) : super(key: key);

  @override
  State<ApplyApp> createState() => _ApplyAppState();
}

class _ApplyAppState extends State<ApplyApp> {
  final _musicKitPlugin = MusicKit();
  MusicAuthorizationStatus _status =
      const MusicAuthorizationStatus.notDetermined();
  String _developerToken = '-----BEGIN PRIVATE KEY-----'
      'MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgiLgd3lmrpKK0sgdz'
      '4m+y1GJXputm9GHAzEvVGyIIAyWgCgYIKoZIzj0DAQehRANCAARAT+VCSKFcMn5Z'
      'sk+XU28fVrv3jOz12s42mW7IepsbEVsJNqbS1VKBb8juo9XiRqcEpFtMvAE739O9'
      'sSJLBsbB'
      '-----END PRIVATE KEY-----';
  String _userToken = '';
  String _countryCode = '';

  MusicSubscription _musicSubsciption = MusicSubscription();
  StreamSubscription<MusicSubscription> _musicSubscriptionStreamSubscription;

  MusicPlayerState _playerState;
  StreamSubscription<MusicPlayerState> _playerStateStreamSubscription;

  MusicPlayerQueue _playerQueue;
  StreamSubscription<MusicPlayerQueue> _playerQueueStreamSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    //
    // _musicSubscriptionStreamSubscription =
    //     _musicKitPlugin.onSubscriptionUpdated.listen((event) {
    //       setState(() {
    //         _musicSubsciption = event;
    //       });
    //     });
    //
    // _playerStateStreamSubscription =
    //     _musicKitPlugin.onMusicPlayerStateChanged.listen((event) {
    //       setState(() {
    //         _playerState = event;
    //       });
    //     });
    //
    // _playerQueueStreamSubscription =
    //     _musicKitPlugin.onPlayerQueueChanged.listen((event) {
    //       setState(() {
    //         _playerQueue = event;
    //       });
    //     });
  }

  @override
  void dispose() {
    _musicSubscriptionStreamSubscription.cancel();
    _playerStateStreamSubscription.cancel();
    _playerQueueStreamSubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final status = await _musicKitPlugin.authorizationStatus;
    final jwt = JWT({
      "iat": now,
      "exp": now + Duration(hours: 12).inSeconds,
      'iss': 'DZQ6SRZXKQ'
    }, header: {
      "alg": "ES256",
      "kid": "9RULML4U2U"
    });

// Sign it (default with HS256 algorithm)
    final token =
        'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjlSVUxNTDRVMlUifQ.eyJpc3MiOiJEWlE2U1JaWEtRIiwiZXhwIjoxNjc5NTk4MDA5LCJpYXQiOjE2NjM4MjEwMDl9.o35PTIc1QY_C_AdOp0ziaD2cCuTyTRvwLntz0I4uSTwXxli3WpnH2qE-NW_ZlvWTwRHDItjkLuVik5OOUQkutA';
//         jwt.sign(ECPrivateKey(_developerToken), algorithm: JWTAlgorithm.ES256);
//
//     print(token);
    // final aStatus = await _musicKitPlugin.requestAuthorizationStatus();
    // print(aStatus);
    await _musicKitPlugin.initialize(
      token,
    );

    // final developerToken = await _musicKitPlugin.requestDeveloperToken();
    final userToken = await _musicKitPlugin.requestUserToken(token);
    print("User token >>>>> $userToken");
    final countryCode = await _musicKitPlugin.currentCountryCode;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _status = status;
      // _developerToken = developerToken;
      _userToken = userToken;
      _countryCode = countryCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('DeveloperToken: $_developerToken\n'),
              Text('UserToken: $_userToken\n'),
              Text('Status: ${_status.toString()}\n'),
              Text('CountryCode: $_countryCode\n'),
              Text('Subscription: ${_musicSubsciption.toString()}\n'),
              Text('PlayerState: ${_playerState?.playbackStatus.toString()}'),
              Text('PlayerQueue: ${_playerQueue?.currentEntry?.title}'),
              TextButton(
                  onPressed: () async {
                    await _musicKitPlugin.setQueue(albumFolklore['type'],
                        item: albumFolklore);

// Play
                    await _musicKitPlugin.play();

// Be informed when the player state changes
                    _musicKitPlugin.onMusicPlayerStateChanged
                        .listen((MusicPlayerState state) {
                      print(state);
                      // Do something with new state
                    });
                  },
                  child: const Text('Shuffle')),
              TextButton(
                  onPressed: () async {
                    final status =
                        await _musicKitPlugin.requestAuthorizationStatus();
                    print(status);
                    setState(() {
                      _status = status;
                    });
                  },
                  child: const Text('Request authorization')),
              TextButton(
                  onPressed: () async {
                    await _musicKitPlugin.setQueue(albumFolklore['type'],
                        item: albumFolklore);
                    await _musicKitPlugin.play();
                  },
                  child: const Text('Play an Album'))
            ],
          ),
        ),
      ),
    );
  }
}

const Map<String, dynamic> albumFolklore = {
  "id": "1528112358",
  "type": "albums",
  "href": "/v1/catalog/us/albums/1528112358?l=en-US",
  "attributes": {
    "artwork": {
      "width": 3000,
      "height": 3000,
      "url":
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/b5/80/dc/b580dca0-349d-036b-e09b-bd849f6affd8/20UMGIM64216.rgb.jpg/{w}x{h}bb.jpg",
      "bgColor": "c6c6c6",
      "textColor1": "000000",
      "textColor2": "070707",
      "textColor3": "272727",
      "textColor4": "2d2d2d"
    },
    "artistName": "Taylor Swift",
    "isSingle": false,
    "url":
        "https://music.apple.com/us/album/folklore-deluxe-version/1528112358",
    "isComplete": true,
    "genreNames": ["Alternative", "Music"],
    "trackCount": 17,
    "isMasteredForItunes": true,
    "releaseDate": "2020-07-24",
    "name": "folklore (deluxe version)",
    "artistUrl": "https://music.apple.com/us/artist/taylor-swift/159260351",
    "recordLabel": "Taylor Swift",
    "upc": "00602435145044",
    "copyright": "℗ 2020 Taylor Swift",
    "playParams": {"id": "1528112358", "kind": "album"},
    "editorialNotes": {
      "standard":
          "A mere 11 months passed between the release of <i>Lover</i> and its surprise follow-up, but it feels like a lifetime. Written and recorded remotely during the first few months of the global pandemic, <i>folklore</i> finds the 30-year-old singer-songwriter teaming up with The National’s Aaron Dessner and long-time collaborator Jack Antonoff for a set of ruminative and relatively lo-fi bedroom pop that’s worlds away from its predecessor. When Swift opens “the 1”—a sly hybrid of plaintive piano and her naturally bouncy delivery—with “I’m doing good, I’m on some new st,” you’d be forgiven for thinking it was another update from quarantine, or a comment on her broadening sensibilities. But Swift’s channelled her considerable energies into writing songs here that double as short stories and character studies, from Proustian flashbacks (“cardigan”, which bears shades of Lana Del Rey) to outcast widows (“the last great american dynasty”) and doomed relationships (“exile”, a heavy-hearted duet with Bon Iver’s Justin Vernon). It’s a work of great texture and imagination. “Your braids like a pattern/Love you to the moon and to Saturn,” she sings on “seven”, the tale of two friends plotting an escape. “Passed down like folk songs, the love lasts so long.” For a songwriter who has mined such rich detail from a life lived largely in public, it only makes sense that she’d eventually find inspiration in isolation.",
      "short":
          "Taylor has one more folklore surprise: a bonus track, “the lakes”."
    },
    "isCompilation": false,
    "contentRating": "explicit"
  }
};
