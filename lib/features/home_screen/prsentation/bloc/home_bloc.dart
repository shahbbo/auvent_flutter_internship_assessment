import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_assets.dart';
import '../../data/models/home_item_model.dart';
import '../../domain/entities/home_item.dart';
import '../../domain/usecases/get_ads_usecase.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import '../../domain/usecases/get_services_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetServicesUseCase getServicesUseCase;
  final GetAdsUseCase getAdsUseCase;
  final GetRestaurantsUseCase getRestaurantsUseCase;

  HomeBloc({
    required this.getServicesUseCase,
    required this.getAdsUseCase,
    required this.getRestaurantsUseCase,
  }) : super(const HomeState()) {
    on<HomeInitialEvent>((event, emit) {
      // Initial state setup if needed
      emit(const HomeState());
      add(LoadHomeDataEvent());
    });
    on<BottomNavTappedEvent>(_bottomNavTapped);
    on<LoadHomeDataEvent>(_loadHomeData);
    on<GetServicesEvent>(_getServices);
    on<GetAdsEvent>(_getAds);
    on<GetRestaurantsEvent>(_getRestaurants);
  }

  Future<void> _bottomNavTapped(
    BottomNavTappedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selectedIndex: event.index, isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }

  List<HomeItem> servicesList = [];
  List<HomeItem> adsList = [];
  final List<HomeItemModel> shortcutsList = [
    HomeItemModel(
      id: 'order_food',
      image: AppAssets.paste,
      name: 'Past\norders',
    ),
    HomeItemModel(
      id: 'coupon',
      image: AppAssets.coupon,
      name: 'Super\nSaver',
      overlayText: 'n',
    ),
    HomeItemModel(
      id: 'must_tries',
      image: AppAssets.mustTries,
      name: 'Must-tries',
      overlayText: 'n',
    ),
    HomeItemModel(
      id: 'give_back',
      image: AppAssets.giveBack,
      name: 'Give Back',
    ),
    HomeItemModel(
      id: 'best_sellers',
      image: AppAssets.star,
      name: 'Best\nSellers',
    ),
  ];
  List<HomeItem> restaurantsList = [];

  Future<void> _loadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _fetchServices(emit);
    await _fetchAds(emit);
    await _fetchRestaurants(emit);
  }

  Future<void> _getServices(
    GetServicesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _fetchServices(emit);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _fetchServices(Emitter<HomeState> emit) async {
    final servicesResult = await getServicesUseCase.call();

    servicesResult.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        ));
      },
      (services) {
        emit(state.copyWith(
          services: services,
        ));
      },
    );
  }

  Future<void> _getAds(
    GetAdsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _fetchAds(emit);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _fetchAds(Emitter<HomeState> emit) async {
    final adsResult = await getAdsUseCase.call();

    adsResult.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        ));
      },
      (ads) {
        emit(state.copyWith(
          ads: ads,
        ));
      },
    );
  }

  Future<void> _getRestaurants(
    GetRestaurantsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _fetchRestaurants(emit);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _fetchRestaurants(Emitter<HomeState> emit) async {
    final restaurantsResult = await getRestaurantsUseCase.call();

    restaurantsResult.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        ));
      },
      (restaurants) {
        emit(state.copyWith(
          restaurants: restaurants,
          isLoading: false,
        ));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure():
        return 'Server error occurred. Please try again later.';
      case NetworkFailure():
        return 'No internet connection. Please check your network.';
      case AuthFailure():
        return (failure as AuthFailure).message;
      case CacheFailure():
        return 'Cache error occurred. Please restart the app.';
      default:
        return 'Unexpected error occurred. Please try again.';
    }
  }
}
