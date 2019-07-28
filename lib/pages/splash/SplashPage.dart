import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/pages/login/login_page.dart';
import 'package:notas/pages/main/MainPage.dart';
import 'package:notas/pages/splash/SplashBloc.dart';
import 'package:notas/util/state_util.dart';
import 'package:notas/util/widget_util.dart';

class SplashPage extends StatelessWidget {

  static const ROUTE = '/';

  SplashBloc _bloc;

  @override
  Widget build(BuildContext context) {
    if(_bloc == null){
      _bloc = SplashBloc();
    }
    return BlocBuilder(
      bloc: _bloc,
      builder: (ctx, state){

        if(state is InitialState){
          _bloc.dispatch(0);
        }

        if(state is SuccessState){
          onDidWidgetLoaded((){
            Navigator.pushReplacementNamed(context,
                state.data ? MainPage.ROUTE : LoginPage.ROUTE);
          });
        }

        return Container(
          width: 160,
          height: 160,
          color: Colors.white,
          child: Center(
            child: Image(image: AssetImage('assets/images/logo.png')),
          ),
        );
      },
    );
  }
}
