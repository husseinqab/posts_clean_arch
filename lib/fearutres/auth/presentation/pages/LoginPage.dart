import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/auth/presentation/bloc/login_validation_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Validation')),
      body: Column(
        children: [
          const Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 30, color: Colors.red),
          ),
          RepositoryProvider(
            create: (context) => LoginValidationBloc(),
            child: LoginForm(),
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        context
            .read<LoginValidationBloc>()
            .add(EmailChanged(email: emailController.text));
      }
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        context
            .read<LoginValidationBloc>()
            .add(PasswordChanged(password: passwordController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginValidationBloc, LoginValidationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                onChanged: (String value) {
                  if (state.isEditing){
                    context
                        .read<LoginValidationBloc>()
                        .add(EmailChanged(email: value));
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: state.emailErrorText),
              ),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                onChanged: (String value) {
                  if (state.isEditing){
                    context
                        .read<LoginValidationBloc>()
                        .add(PasswordChanged(password: value));
                  }
                },
                decoration: InputDecoration(
                    hintText: 'password',
                    errorText: state.passwordErrorText),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (state.isValidForm){
                      print("all valid");
                    }
                  },
                  child: Text("Login"))
            ],
          ),
        );
      },
    );
  }
}
