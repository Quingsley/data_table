// ignore_for_file: avoid_print, strict_raw_type

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

// ignore: public_member_api_docs
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}
