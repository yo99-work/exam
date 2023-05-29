import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/model/notification/notification.dart';
import 'package:exam/src/data/repository/notification_repository.dart';

import '../../../di/service_locator.dart';
import '../../home/bloc/product/product_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final notificationRepository = getIt.get<NotificationRepository>();
  final throttleDuration = const Duration(milliseconds: 100);

  NotificationBloc() : super(const NotificationState()) {
    on<NotificationFetched>(
      _onNotificationFetch,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onNotificationFetch(NotificationFetched event,
      Emitter<NotificationState> emit,) async {
    try {
      List<Notification> models = await notificationRepository.getNotification(event.userId);
      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          notifications: models,
          hasReachedMax: false));
    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure, notifications: []));
    }
  }
}