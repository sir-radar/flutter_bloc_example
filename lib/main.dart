import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Block Pattern Demo',
      home: BlocProvider(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final IncrementBloc incrementBloc = IncrementBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: incrementBloc.output,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              return Text("Tapped ${snapshot.data} times");
            }),
       
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          incrementBloc.increment.add(null);
        },
      ),
    );
  }
}


//Block pattern
class IncrementBloc implements BlocBase{
  int _counter = 0;

  //streams for the counter
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _add => _counterController.sink;
  Stream<int> get output => _counterController.stream;

  //streams for events
  StreamController _eventController = StreamController();
  StreamSink get increment => _eventController.sink;

  IncrementBloc(){
    _eventController.stream.listen(_onData);
      }

      void _onData(event) {
        _counter += 1;
        _add.add(_counter);
      }

      @override
      void dispose() {
        _eventController.close();
        _counterController.close();
      }

      @override
      void addListener(listener) {
        // TODO: implement addListener
      }

      @override
      // TODO: implement hasListeners
      bool get hasListeners => null;
    
      @override
      void notifyListeners() {
        // TODO: implement notifyListeners
      }
    
      @override
      void removeListener(listener) {
        // TODO: implement removeListener
      }
}