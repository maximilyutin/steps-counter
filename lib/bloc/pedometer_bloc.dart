import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'pedometer_event.dart';
part 'pedometer_state.dart';

class PedometerBloc extends Bloc<PedometerEvent, PedometerState> {

    final Stream<int> _stream;
    StreamSubscription<int> _subscription;

    PedometerBloc(this._stream);

    @override
    PedometerState get initialState => Initial();

    @override
    Stream<PedometerState> mapEventToState(PedometerEvent event) async* {

        if (event is StartListening) {
            _subscription = _stream.listen((stepsCount) => add(UpdateData(stepsCount: stepsCount)),
                onError: (error) => add(GetError(error: error)));
        }

        if (event is UpdateData) {
            yield Updated(stepsCount: event.stepsCount);
        }

        if (event is GetError) {
            yield Failed(error: event.error);
        }

        if (event is StopListening) {
            _subscription?.cancel();
            _subscription = null;
        }
    }

    @override
    Future<void> close() {
        _subscription?.cancel();
        return super.close();
    }

}