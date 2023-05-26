import 'package:exam/src/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../constants/asset.dart';
import 'bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  final bool isPresentModel;

  const LoginPage({super.key, required this.isPresentModel});

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

        if(state.status.isSuccess && isPresentModel) {
          Navigator.pop(context);
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
                      Spacer(flex: 1,),
                      _GoogleLoginButton(),
                      SizedBox(height: 150,)
                    ],
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


