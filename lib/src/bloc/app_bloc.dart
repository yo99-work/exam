import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/repository/authen_repository.dart';

import '../data/model/user/user.dart';
import '../di/service_locator.dart';

part 'app_event.dart';
part 'app_state.dart';


class AppBloc extends Bloc<AppEvent, AppState> {

  AppBloc():super(
      (getIt.get<AuthenRepository>().currentUser.isNotEmpty ?? false) ?
      AppState.authenticated(getIt.get<AuthenRepository>().currentUser):
      const AppState.unauthenticated()
  ) {

    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenRepository.user.listen(
          (user) => add(_AppUserChanged(user)),
    );
  }
  
  final AuthenRepository _authenRepository = getIt.get<AuthenRepository>();
  late final StreamSubscription<User> _userSubscription;


  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

