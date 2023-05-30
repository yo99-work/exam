import 'package:exam/src/config/theme.dart';
import 'package:exam/src/pages/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../bloc/app_bloc.dart';
import '../../constants/asset.dart';
import '../../widgets/navigation_icon.dart';
import 'bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  final bool isPresentMode;

  const LoginPage({super.key, required this.isPresentMode});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
          if (state.status.isSuccess && isPresentMode) {
            Navigator.pop(context);
            context
                .read<CartBloc>()
                .add(CartFetched(context.read<AppBloc>().state.user.id ?? ""));
          } else if (state.status.isSuccess) {
            context
                .read<CartBloc>()
                .add(CartFetched(context.read<AppBloc>().state.user.id ?? ""));
          }
        },
        child: Container(
            decoration:
                const BoxDecoration(gradient: CustomTheme.primaryGradient),
            // color: CustomTheme.primary,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Asset.EXAM_LOGO_IMAGE,
                  height: 120,
                ),
                Positioned(
                  bottom: 40,
                  child: _GoogleLoginButton(width*0.8),
                ),
                (!isPresentMode)
                    ? const SizedBox(height: 0)
                    : Positioned(
                        top: 40,
                        left: 12,
                        child: NavigationIcon(
                          icon: Icons.arrow_back,
                          notificationValue: 0,
                          colorIcon: CustomTheme.white,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
              ],
            )));
  }
}

class _GoogleLoginButton extends StatelessWidget {
  double width;

  _GoogleLoginButton(this.width);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: CustomTheme.primary,
      backgroundColor: CustomTheme.white,
      minimumSize: Size(width, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text("SIGN IN WITH GOOGLE",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      style: raisedButtonStyle,
      icon: const Icon(FontAwesomeIcons.google, color: CustomTheme.primary),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}
