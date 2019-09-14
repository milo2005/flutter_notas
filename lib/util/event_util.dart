class BaseEvent {}

class SaveEvent<T> extends BaseEvent {
  T data;

  SaveEvent({this.data});
}

class ReadyEvent extends BaseEvent {}

