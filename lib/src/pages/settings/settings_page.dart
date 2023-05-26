import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam/src/bloc/app_bloc.dart';
import 'package:exam/src/config/theme.dart';
import 'package:exam/src/pages/login/login_page.dart';
import 'package:exam/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user/user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          color: CustomTheme.primary,
          child: (state.status == AppStatus.authenticated) ? ProfileView(user: state.user,) : const LoginPage(isPresentModel: false,),
        );
      },
    );
  }
}

class ProfileView extends StatelessWidget {
  final User user;
  const ProfileView({
    super.key, required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        Column(
          children: [
        CachedNetworkImage(
          width: 100,
          height: 100,
          imageUrl: user.photo ?? "",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: CustomTheme.stoke,
                  style: BorderStyle.solid,
                  width: 0.5),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.colorBurn)),
            ),
          ),
          // placeholder: (context, url) => (),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "${user.name}",
          style: const TextStyle(
              fontSize: 20,
              color: CustomTheme.white,
              fontWeight: FontWeight.w700),
        ),
          ],
        ),
        const Spacer(
          flex: 1,
        ),
        AppButton(
          text: "Logout",
          width: MediaQuery.of(context).size.width * 0.8,
          bgColor: CustomTheme.white,
          textColor: CustomTheme.primary,
          onClick: () {
            context.read<AppBloc>().add(AppLogoutRequested());
          },

        ),
        const SizedBox(
          height: 150,
        )
      ],
    );
  }
}
