import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './widgets/detail_screen.dart';
import './widgets/list_item.dart';
import './widgets/shimmer_list.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  static final ThemeData mainAppTheme = ThemeData(
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          bodyText1: const TextStyle(
            fontFamily: 'Quicksand',
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
    appBarTheme: AppBarTheme(
      toolbarTextStyle: ThemeData.light()
          .textTheme
          .copyWith(
            headline6: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          )
          .bodyText2,
      titleTextStyle: ThemeData.light()
          .textTheme
          .copyWith(
            headline6: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 21,
            ),
          )
          .headline6,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF2a4494),
      onPrimary: Color(0xFFffffff),
      primaryContainer: Color(0xFF606fc5),
      onPrimaryContainer: Color(0xFF001e65),
      secondary: Color(0xFF44cfcb),
      onSecondary: Color(0xFF000000),
      secondaryContainer: Color(0xFF80fffe),
      onSecondaryContainer: Color(0xFF009d9a),
      tertiary: Color(0xFF525E7D),
      onTertiary: Color(0xFFffffff),
      tertiaryContainer: Color(0xFFD9E2FF),
      onTertiaryContainer: Color(0xFF0E1A37),
      error: Color(0xFFBA1B1B),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD4),
      onErrorContainer: Color(0xFF410001),
      background: Color(0xFFFBFDFD),
      onBackground: Color(0xFF191C1D),
      surface: Color(0xFFFBFDFD),
      onSurface: Color(0xFF191C1D),
    ),
  );

  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery App',
      debugShowCheckedModeBanner: false,
      theme: mainAppTheme,
      home: const MyHomePage(title: 'Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _images = [];
  final Uri _url = Uri.parse(
      'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9');
  bool _showImg = false;

  Future<void> _getImages() async {
    http.Response response = await http.get(_url);
    List<dynamic> imgData = json.decode(response.body);

    for (var prop in imgData) {
      _images.add({
        'author': prop['user']['name'],
        'fullImage': Image(image: NetworkImage(prop['urls']['regular'])),
        'thumbImage': Image(image: NetworkImage(prop['urls']['small_s3'])),
      });
    }
    setState(() {
      _showImg = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: !_showImg
          ? ShimmerList(handler: () async => await _getImages())
          : Scrollbar(
              child: ListView.builder(
                itemCount: _images.length,
                // separatorBuilder: (BuildContext context, int index) => const Divider(
                //   color: Colors.black54,
                // ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: ListItem(
                          author: _images[index]['author'],
                          avatar: _images[index]['thumbImage'],
                          showImg: _showImg,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailScreen(
                                  image: _images[index]['fullImage'],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
