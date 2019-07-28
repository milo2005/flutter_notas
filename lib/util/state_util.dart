class BaseState{}

class InitialState extends BaseState{}

class LoadingState extends BaseState{}

class SuccessState<T> extends BaseState{
  T data;
  SuccessState({this.data});

}

class ErrorState extends BaseState{
  String msg;
  ErrorState({this.msg});
}