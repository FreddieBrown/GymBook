import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(new GymBook());

class GymBook extends StatelessWidget {
  final _work = Runes(' \u{1F3CB} ');
  final _work1 = Runes('\u{1F501}');
  final _work2 = Runes('\u{1F938}');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Book',
      theme: new ThemeData(
        primarySwatch: Colors.blue,// Add the 3 lines from here...
//        primaryColor: Colors.red,
        accentColor: Colors.blue,
//        dividerColor: Colors.red,
      ),
//      home: new MyHomePage(title: 'GymBook'),
//        home: new homeList(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Routines "+String.fromCharCodes(_work1)),
                Tab(text: "Workouts "+String.fromCharCodes(_work)),
                Tab(text: "Exercises "+String.fromCharCodes(_work2)),
              ],
            ),
            title: Text('GymBook'),
            actions: <Widget>[      // Add 3 lines from here...
              new IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: null
              ),
            ],
          ),
          body: TabBarView(
            children: [
              RoutineList(),
              HomeList(),
              ExercisesList(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.adb),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeList extends StatefulWidget{
  @override
  HomeListState createState() => new HomeListState();
}

/// This is used to describe the state of the homeList StatefulWidget. It uses
/// _workouts() as its body.
class HomeListState extends State<HomeList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _workouts(),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }

  /// This builds a list using _workout() which is shown by homeList
  Widget _workouts() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          return _workout();
        }
    );
  }

  /// Returns a single ListTile Widget
  Widget _workout() {
    var time = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    var formatter1 = new DateFormat('jm');
    String formatted = formatter.format(time);
    String formatted1 = formatter1.format(time);
    return ListTile(
      title: Text(
        "$formatted at $formatted1",
        style: _biggerFont,
      ),
      onTap: () {
        setState(() {
          print("Hello");
        });
      },
    );
  }
}

class RoutineList extends StatefulWidget{
  @override
  RoutineListState createState() => new RoutineListState();
}

class RoutineListState extends State<RoutineList>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
          child: Icon(Icons.list),
      ),
        floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        )
    );
  }
}

class ExercisesList extends StatefulWidget{
  @override
  ExercisesListState createState() => new ExercisesListState();
}

class ExercisesListState extends State<ExercisesList>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
          child: Icon(Icons.list)
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      )
    );
  }
}
