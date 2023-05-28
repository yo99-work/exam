import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/repository/authen_repository.dart';

import '../data/model/user/user.dart';
import '../di/service_locator.dart';

part 'app_event.dart';

part 'app_state.dart';


class AppBloc extends Bloc<AppEvent, AppState> {

  AppBloc() :super(AppState(status: AppStatus.unauthenticated, user: User.empty)) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenRepository.user.listen(
          (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenRepository _authenRepository = getIt.get<AuthenRepository>();
  late final StreamSubscription<User> _userSubscription;


  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    return emit(state.copyWith(
        status: event.user.isNotEmpty ? AppStatus.authenticated : AppStatus
            .unauthenticated, user: event.user));
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

