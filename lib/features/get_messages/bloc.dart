import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';


part 'events.dart';

part 'model.dart';

part 'states.dart';

class GetMessagesBloc extends Bloc<GetMessagesEvents, GetMessagesStates> {
  final DioHelper _dio;

  GetMessagesBloc(this._dio) : super(GetMessagesStates()) {
    on<GetMessagesEvent>(_getData);
    on<AppendMessageEvent>(_addData);
  }


  void _getData(
    GetMessagesEvent event,
    Emitter<GetMessagesStates> emit,
  ) async {
    emit(GetMessagesLoadingState());

    final response = await _dio.get("");
    if (response.isSuccess) {
      emit(GetMessagesSuccessState(list: []));
    } else {
      emit(GetMessagesFailedState(
          msg: response.msg, statusCode: response.statusCode));
    }
  }

  FutureOr<void> _addData(
      AppendMessageEvent event, Emitter<GetMessagesStates> emit) {
    // _fakeList.insert(
    //     0,
    //     MessageModel(
    //         id: 1,
    //         data: event.data,
    //         isMe: true,
    //         date: DateFormat.jm().format(DateTime.now()),
    //      ));

    emit(
      GetMessagesSuccessState(list: _fakeList),
    );
  }
}
