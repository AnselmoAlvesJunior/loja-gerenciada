import 'package:flutter/material.dart';
import 'package:loja_gerenciada/blocs/login_bloc.dart';
import 'package:loja_gerenciada/widgets/input_fields.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content:
                        Text("Você nao possui os  privilegios necessarios!"),
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }


  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        builder: (context, snapshot) {
          print(snapshot.data);
          switch (snapshot.data) {
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                ),
              );
            case LoginState.FAIL:
            case LoginState.SUCCESS:
            case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 0.0, height: 0.0
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.store_mall_directory,
                            color: Colors.pinkAccent,
                            size: 160,
                          ),
                          InputField(Icons.person_outline, "Usuário", false,
                              _loginBloc.outEmail, _loginBloc.changeEmail),
                          InputField(
                              Icons.lock_outline,
                              "Senha",
                              true,
                              _loginBloc.outPassword,
                              _loginBloc.changePassword),
                          SizedBox(
                            height: 32,
                          ),
                          StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onLongPress: snapshot.hasData
                                        ? _loginBloc.submit
                                        : null,
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Colors.pinkAccent;
                                          else if (states
                                              .contains(MaterialState.disabled))
                                            return Colors.pinkAccent
                                                .withAlpha(140);
                                          else
                                            return Colors.pinkAccent;
                                        },
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Entrar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
