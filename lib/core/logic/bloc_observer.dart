import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_log/quick_log.dart';

class MyBlocObserver extends BlocObserver {
  Logger log = const Logger("");
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log.debug('${bloc.runtimeType} ( onCreate )');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (change.nextState.runtimeType.toString().contains("Failed")) {
      log.error(
          '${bloc.runtimeType}  ( onChange ), ${change.currentState.runtimeType}==> ${change.nextState.runtimeType}',
          includeStackTrace: false);
    } else {
      log.fine(
          '${bloc.runtimeType}  ( onChange ), ${change.currentState.runtimeType}==> ${change.nextState.runtimeType}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.error('${bloc.runtimeType} ( onError ), $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log.warning('${bloc.runtimeType} ( onClose )');
  }
}
