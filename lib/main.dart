import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          BlocProvider(create: (context) => CounterBloc(0), child: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Consumer'),
      ),
      body: Center(
        child: BlocConsumer<CounterBloc, int>(
          buildWhen: (previous, current) {
            if(current > 1){
              return true;
            }

            return false;
          },
          listenWhen: (previous, current) {
            if(current > 5){
              return true;
            }

            return false;
          },
          builder: (context, state) => Text('Angka $state'),
          listener: (context, state) {
            // if (state > 10)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Diatas 10'),
                ),
              );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterBloc>().increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterBloc extends Cubit<int> {
  CounterBloc(int initialState) : super(0);

  void increment() => emit(state + 1);
}
