import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyLoginTest extends StatefulWidget {
  const SpotifyLoginTest({Key key}) : super(key: key);

  @override
  State<SpotifyLoginTest> createState() => _SpotifyLoginTestState();
}

class _SpotifyLoginTestState extends State<SpotifyLoginTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            final url =
                "https://accounts.spotify.com/authorize?client_id=5f70513e09194d8489541fa36fa452c8&response_type=token&redirect_uri=http%3A%2F%2Fchune.com%2Fcallback&show_dialog=false&utm_source=spotify-sdk&utm_medium=android-sdk&utm_campaign=android-sdk&scope=app-remote-control%20%20user-modify-playback-state%20%20playlist-read-private%20%20playlist-modify-public%20user-read-currently-playing";
            final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: "my-custom-app");
            print(result);
            return;
            showDialog(
                context: context,
                builder: (c) =>
                    WebViewScreen(
                      url: url,
                    )).then((value) {
              showDialog(context: context, builder: (c) =>
                  AlertDialog(
                    content: Text('$value'),
                  ));
            });
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewController controller;

  WebViewScreen({Key key, this.url}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (c) {
          controller = c;
          controller.loadUrl(url);
        },
        initialUrl: url,
        onPageStarted: (url) {
          print("PAGE STARTED>>>>>>>>>>>>>$url");
          var uri = Uri.parse(url);
          if (uri.host.contains('chune.com')) {
            Navigator.pop(context, uri.data.parameters);
          }
        },
      ),
    );
  }
}
