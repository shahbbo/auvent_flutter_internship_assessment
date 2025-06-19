part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class LoadHomeDataEvent extends HomeEvent {}

class BottomNavTappedEvent extends HomeEvent {
  final int index;

  const BottomNavTappedEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class GetServicesEvent extends HomeEvent {}

class GetAdsEvent extends HomeEvent {}

class GetRestaurantsEvent extends HomeEvent {}
