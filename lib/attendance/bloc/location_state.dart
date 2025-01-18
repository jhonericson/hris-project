part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final String location;

  const LocationSuccess({required this.location});
  @override
  List<Object> get props => [location];
}

final class LocationFailure extends LocationState {
  final String message;

  const LocationFailure({required this.message});
  @override
  List<Object> get props => [message];
}
