part of 'pedometer_bloc.dart';

abstract class PedometerEvent extends Equatable {
    final List _props;

    PedometerEvent([this._props = const []]);

    @override
    List<Object> get props => _props;
}

class StartListening extends PedometerEvent {

    @override
    String toString() => 'StartListening';
}

class StopListening extends PedometerEvent {

    @override
    String toString() => 'StopListening';
}

class UpdateData extends PedometerEvent {
    final stepsCount;

    UpdateData({@required this.stepsCount}) : super([stepsCount]);

    @override
    String toString() => 'UpdateData { stepsCount: $stepsCount }';
}

class GetError extends PedometerEvent {
    final error;

    GetError({@required this.error}) : super([error]);

    @override
    String toString() => 'GetError { error: $error }';
}