import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KyPaint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset pos = Offset(0, 0);
  List<Offset> listPos = <Offset>[];

  static Color color = Colors.black;
  List<Color> listColor = <Color>[color];

  static double brushSize = 5;
  List<double> listSize = <double>[brushSize];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox box = context.findRenderObject();
                  pos = box.globalToLocal(details.globalPosition);

                  listPos = List.from(listPos)..add(pos);
                  listColor = List.from(listColor)..add(color);
                  listSize = List.from(listSize)..add(brushSize);
                });
              },
              child: Container(
                child: CustomPaint(
                  painter: Draw(listPos, listColor, listSize),
                  child: Container(),
                ),
              ),
            ),
          ),
          Container(
              color: Colors.black54,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.brush,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        color = Colors.blue;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.brush,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        color = Colors.red;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.brush,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      setState(() {
                        color = Colors.yellow;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.brightness_1,
                      color: Colors.black,
                      size: 10,
                    ),
                    onPressed: () {
                      setState(() {
                        brushSize = 5;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.brightness_1,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        brushSize = 10;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        pos = Offset(0, 0);
                        listPos = <Offset>[];

                        color = Colors.black;
                        listColor = <Color>[color];

                        double brushSize = 5;
                        listSize = <double>[brushSize];
                      });
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class Draw extends CustomPainter {
  Draw(this.listPost, this.listColor, this.listSize);
  final List<Offset> listPost;
  final List<Color> listColor;
  final List<double> listSize;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;

    for (var i = 0; i < listPost.length; i++) {
      paint.color = listColor[i];
      canvas.drawCircle(listPost[i], listSize[i], paint);
    }

//    var c = Offset(size.width/2, size.height/2);
//    canvas.drawCircle(c, 50, paint);
//
//    var rect = Rect.fromLTWH(size.width/3, size.height/2, 100, 150);
//    paint.color = Colors.blue;
//    canvas.drawRect(rect, paint);
//
//    paint.color = Colors.green;
//    paint.strokeWidth = 10;
//
//    var p1= Offset(0, 500);
//    var p2= Offset(size.width/2, 100);
//    canvas.drawLine(p1, p2, paint);
//
//    var p11= Offset(size.width/2, 100);
//    var p22= Offset(size.width, 500);
//    canvas.drawLine(p11, p22, paint);
  }

  @override
  bool shouldRepaint(Draw old) {
    return old.listPost != listPost;
  }
}
