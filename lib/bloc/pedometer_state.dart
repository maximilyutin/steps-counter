part of 'pedometer_bloc.dart';

abstract class PedometerState extends Equatable {
    final List _props;

    PedometerState([this._props = const []]);

    @override
    List<Object> get props => _props;
}

class Initial extends PedometerState {

    @override
    String toString() => 'Initial';
}

class Updated extends PedometerState {
    final stepsCount;

    Updated({@required this.stepsCount}) : super([stepsCount]);

    @override
    String toString() => 'Updated { stepsCount: $stepsCount }';
}

class Failed extends PedometerState {
    final error;

    Failed({@required this.error}) : super([error]);

    @override
    String toString() => 'Failed { error: $error }';
}