part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class NotificationFetched extends NotificationEvent {
  final String userId;
  NotificationFetched(this.userId);

  @override
  List<Object> get props => [userId];
}