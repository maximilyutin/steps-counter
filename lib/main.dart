import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:steps_counter/bloc/pedometer_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Pedometer pedometer = Pedometer();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
          create: (context) => PedometerBloc(pedometer.pedometerStream),
          child: MyHomePage(title: 'Steps Counter')),
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
  void initState() {
    BlocProvider.of<PedometerBloc>(context).add(StartListening());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final indicatorSize = MediaQuery.of(context).size.shortestSide / 2;

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: StepsProgressIndicator(
                goalStepsCount: 10000,
                size: indicatorSize ))
    );
  }
}

class StepsProgressIndicator extends StatelessWidget {
  const StepsProgressIndicator({
    Key key,
    @required this.goalStepsCount,
    this.size
  }) : super(key: key);

  final goalStepsCount;
  final size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double _strokeWidth = constraints.maxWidth*0.09;

            return InkWell(
              borderRadius: BorderRadius.circular(constraints.maxWidth/2),
              onTap: () {

              },
              child: Container(
                constraints: BoxConstraints(maxHeight: constraints.maxWidth),
                padding: EdgeInsets.all(_strokeWidth/2),
                child:


                BlocBuilder<PedometerBloc, PedometerState>(builder: (context, state) {

                  int curStepsCount = (state is Updated) ? state.stepsCount : 0;

                  if (state is Failed) {
                    print('Pedometer failed: ${state.error}');
                    curStepsCount = null;
                  }

                  return Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: <Widget>[
                      FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Column(
                              children: <Widget>[
                                Text("${curStepsCount ?? '?'}", style: TextStyle(color: theme.primaryColorDark)),
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
                  );
                }),
              ),
            );
          }
      ),
    );
  }
}
