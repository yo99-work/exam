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

        if(state.status.isSuccess && isPresentMode) {
          Navigator.pop(context);
          context.read<CartBloc>().add(CartFetched(context.read<AppBloc>().state.user.id ?? ""));
        }else if (state.status.isSuccess) {
          context.read<CartBloc>().add(CartFetched(context.read<AppBloc>().state.user.id ?? ""));
        }
      },
      child:
        Container(
          color: CustomTheme.primary,
          child:
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Asset.EXAM_LOGO_IMAGE,
                    height: 120,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1,),
                      _GoogleLoginButton(),
                      const SizedBox(height: 150,)
                    ],
                  ),
                  (!isPresentMode) ? const SizedBox(height:0):
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
                ],
              )
        )
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: CustomTheme.primary),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: CustomTheme.primary),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}


