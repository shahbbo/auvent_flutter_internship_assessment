import '../../../../core/local/hive_helper.dart';
import '../models/home_item_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheServices(List<HomeItemModel> items);
  Future<void> cacheRestaurants(List<HomeItemModel> items);
  Future<void> cacheAds(List<HomeItemModel> items);

  List<HomeItemModel> getCachedServices();
  List<HomeItemModel> getCachedRestaurants();
  List<HomeItemModel> getCachedAds();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final HiveHelper<HomeItemModel> servicesBox;
  final HiveHelper<HomeItemModel> restaurantsBox;
  final HiveHelper<HomeItemModel> adsBox;

  HomeLocalDataSourceImpl({
    required this.servicesBox,
    required this.restaurantsBox,
    required this.adsBox,
  });

  Future<void> _cacheList(
    HiveHelper<HomeItemModel> box,
    List<HomeItemModel> items,
  ) async {
    await box.clear();
    for (int i = 0; i < items.length; i++) {
      await box.add(i.toString(), items[i]);
    }
  }

  List<HomeItemModel> _getCachedList(
      HiveHelper<HomeItemModel> box, String type) {
    final list = box.getAll();
    if (list.isEmpty) throw CacheException('No cached $type found');
    return list;
  }

  @override
  Future<void> cacheServices(List<HomeItemModel> items) =>
      _cacheList(servicesBox, items);

  @override
  Future<void> cacheRestaurants(List<HomeItemModel> items) =>
      _cacheList(restaurantsBox, items);

  @override
  Future<void> cacheAds(List<HomeItemModel> items) => _cacheList(adsBox, items);

  @override
  List<HomeItemModel> getCachedServices() =>
      _getCachedList(servicesBox, 'services');

  @override
  List<HomeItemModel> getCachedRestaurants() =>
      _getCachedList(restaurantsBox, 'restaurants');

  @override
  List<HomeItemModel> getCachedAds() => _getCachedList(adsBox, 'ads');
}
