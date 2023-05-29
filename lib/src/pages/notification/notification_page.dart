import 'package:exam/src/pages/notification/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme.dart';
import '../../data/repository/authen_repository.dart';
import '../../di/service_locator.dart';
import '../../widgets/app_image_view.dart';
import '../../widgets/navigation_icon.dart';
import '../home/bloc/product/product_bloc.dart';

class NotificationPage extends StatefulWidget {
  final bool isPresentMode;

  const NotificationPage({super.key, required this.isPresentMode});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();
    getIt<AuthenRepository>().currentUser.then((user) {
      context.read<NotificationBloc>().add(NotificationFetched(user.id ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: CustomTheme.background,
        child: Stack(
          alignment: Alignment.center,
            children: [
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  switch (state.status) {
                    case LazyLoadStatus.failure:
                      return const Center(child: Text('failed to fetch notification'));
                    case LazyLoadStatus.success:
                      if (state.notifications.isEmpty) {
                        return const Center(child: Text('data not found.'));
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 90, bottom: 123),
                        child: ListView.builder(
                            itemCount: state.notifications.length,
                            itemBuilder: (context, index) {
                              return _createNotificationItem(state, index);
                            }),
                      );

                    case LazyLoadStatus.initial:
                      return const Center(child: CircularProgressIndicator());
                  }

                },
              ),

              (!widget.isPresentMode) ? SizedBox(height: 0) :
              Positioned(
                top: 40,
                left: 12,
                child: NavigationIcon(
                  icon: Icons.arrow_back,
                  notificationValue: 0,
                  colorIcon: CustomTheme.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Positioned(
                top: 50,

                child: Text(
                  "Notification",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: CustomTheme.primary),
                ),
              ),
            ]
        ),
      ),
    );
  }

  Container _createNotificationItem(NotificationState state, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: CustomTheme.stoke, style: BorderStyle.solid, width: 0.8),
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: AppImageView(
              imageUrl: state.notifications[index].image ?? "",
              radius: 12,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${state.notifications[index].title}",
                  softWrap: true,
                  maxLines: 3,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
                Text(state.notifications[index].description ?? "",
                    style: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )),
                const SizedBox(
                  height: 12,
                ),
                Text(state.notifications[index].date ?? "",
                    style: const TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

}
