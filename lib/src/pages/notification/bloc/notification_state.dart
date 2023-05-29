part of 'notification_bloc.dart';

final class NotificationState extends Equatable {
  const NotificationState({
    this.status = LazyLoadStatus.initial,
    this.notifications = const <Notification>[],
    this.hasReachedMax = false,
  });

  final LazyLoadStatus status;
  final List<Notification> notifications;
  final bool hasReachedMax;

  NotificationState copyWith({
    LazyLoadStatus? status,
    List<Notification>? notifications,
    bool? hasReachedMax,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, products: ${notifications.length} }''';
  }

  @override
  List<Object> get props => [status, notifications, hasReachedMax];
}
