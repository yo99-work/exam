import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.d("AppBlocObserver ${transition.toString()}");

    print("AppBlocObserver ${transition.toString()}");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.d(error);
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}