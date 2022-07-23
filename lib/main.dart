import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './models/detail_screen.dart';

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
            fontSize: 15,
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
              fontSize: 20,
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

  getImages() async {
    http.Response response = await http.get(_url);
    List<dynamic> imgData = json.decode(response.body);

    for (var prop in imgData) {
      _images.add({
        'author': prop['user']['name'],
        'imageUrl': prop['urls']['regular'],
      });
    }
    setState(() {
      _showImg = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showImg) {
      getImages();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollbar(
        child: ListView.separated(
          itemCount: _images.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black54,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      child: !_showImg
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : Image(
                              image: NetworkImage(
                                  _images[index]['imageUrl'] as String),
                            ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailScreen(
                                imagePath: _images[index]['imageUrl'],
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Author: ${_images[index]['author']}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
