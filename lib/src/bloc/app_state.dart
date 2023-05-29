part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

final class AppState extends Equatable {
   AppState({required this.status, required this.user}) {
     _initialize();
   }

   Future<void> _initialize() async {
     final currentUser = await getIt<AuthenRepository>().currentUser;
     user = currentUser;
     if (currentUser.isEmpty) {
       status = AppStatus.unauthenticated;
     }else {
       status = AppStatus.authenticated;
     }
   }

   AppStatus status;
   User user;

   AppState copyWith({
     AppStatus? status,
     User? user,
   }) {
     return AppState(
       status: status ?? this.status,
       user: user ?? this.user
     );
   }

  @override
  List<Object> get props => [status, user];

}
