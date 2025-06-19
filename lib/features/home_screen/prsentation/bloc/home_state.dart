part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final bool isLoading;
  final List<HomeItem> services;
  final List<HomeItem> ads;
  final List<HomeItem> restaurants;
  final String error;

  const HomeState({
    this.selectedIndex = 0,
    this.isLoading = false,
    this.services = const [],
    this.ads = const [],
    this.restaurants = const [],
    this.error = '',
  });

  HomeState copyWith({
    int? selectedIndex,
    bool? isLoading,
    List<HomeItem>? services,
    List<HomeItem>? ads,
    List<HomeItem>? restaurants,
    String? error,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      services: services ?? this.services,
      ads: ads ?? this.ads,
      restaurants: restaurants ?? this.restaurants,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [selectedIndex, isLoading, services, ads, restaurants, error];
}
