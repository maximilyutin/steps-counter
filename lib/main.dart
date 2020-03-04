import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Steps Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final stepsIndicatorSize = MediaQuery.of(context).size.shortestSide / 2;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
              alignment: Alignment.center,
              width: stepsIndicatorSize,
              height: stepsIndicatorSize,
              child: StepsProgressIndicator()),
        ));
  }
}

class StepsProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int goalStepsCount = 10000;
    int curStepsCount = 2412;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double _strokeWidth = constraints.maxWidth*0.09;

          return InkWell(
            borderRadius: BorderRadius.circular(constraints.maxWidth/2),
            onTap: () {

            },
            child: Container(
              constraints: BoxConstraints(maxHeight: constraints.maxWidth),
              padding: EdgeInsets.all(_strokeWidth/2),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          children: <Widget>[
                            Text("$curStepsCount", style: TextStyle(color: theme.primaryColorDark),),
                            Text(
                              "/$goalStepsCount steps",
                              textScaleFactor: 0.3,
                              style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                      )),
                  CircularProgressIndicator(
                      value: curStepsCount / goalStepsCount,
                      strokeWidth: _strokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor.withOpacity(0.8)),
                      backgroundColor: theme.primaryColor.withOpacity(0.1)),
                ],
              ),
            ),
          );
        }
    );
  }
}
