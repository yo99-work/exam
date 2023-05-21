import 'package:exam/src/app_route.dart';
import 'package:exam/src/constants/asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_a_bloc/counter_a_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoute.another),
            icon: Icon(Icons.navigate_next),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Asset.LOGO_IMAGE),
            const Text(
              'Counter A',
            ),
            BlocBuilder<CounterABloc, CounterAState>(
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterABloc>().add(CounterAEventReset()),
            tooltip: 'Reset',
            child: const Icon(Icons.restore),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterABloc>().add(CounterAEventAdd()),
            tooltip: 'Add',
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
