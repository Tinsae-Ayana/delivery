import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class LocalStorage {
  LocalStorage({DatabaseFactory? databaseFactory})
      : _databaseFactory = databaseFactory ?? databaseFactoryIo {
    openDatabase();
  }
  final DatabaseFactory _databaseFactory;
  late final String _dbPath;
  late final StoreRef _storeOrder;
  late final StoreRef _storeCart;
  late final StoreRef _storeFavorite;
  late final Database? _database;

  Future<void> openDatabase() async {
    if (_database != null) {
      return;
    }
    _storeCart = intMapStoreFactory.store('Cart');
    _storeFavorite = intMapStoreFactory.store('Favorite');
    _storeOrder = intMapStoreFactory.store('Orders');
    final path = await getApplicationDocumentsDirectory();
    _dbPath = join(path.path, 'appDatabase');
    _database = await _databaseFactory.openDatabase(_dbPath);
  }

  Future<void> deleteFromOrder({data, store}) async {
    if (_database == null) {
      await openDatabase();
    }
    switch (store) {
      case 'order':
        final finder = Finder(filter: Filter.custom((e) {
          return e == data ? true : false;
        }));
        await _storeOrder.delete(_database!, finder: finder);
        break;
      case 'favorite':
        final finder = Finder(filter: Filter.custom((e) {
          return e == data ? true : false;
        }));
        await _storeFavorite.delete(_database!, finder: finder);
        break;
      case 'cart':
        final finder = Finder(filter: Filter.custom((e) {
          return e == data ? true : false;
        }));
        await _storeCart.delete(_database!, finder: finder);
    }
  }

  Future<void> insertIntoOrder({data, store}) async {
    if (_database == null) {
      await openDatabase();
    }
    switch (data) {
      case 'order':
        await _storeOrder.add(_database!, data);
        break;
      case 'favorite':
        await _storeFavorite.add(_database!, data);
        break;
      case 'cart':
        await _storeCart.add(_database!, data);
    }
  }

  Future<List<String>> readAllFromOrder({store}) async {
    if (_database == null) {
      await openDatabase();
    }

    switch (store) {
      case 'order':
        final finder =
            Finder(sortOrders: [SortOrder('priority'), SortOrder('id')]);
        final snapshot = await _storeOrder.find(_database!, finder: finder);
        return snapshot.map((e) => e.value.toString()).toList();

      case 'favorite':
        final finder =
            Finder(sortOrders: [SortOrder('priority'), SortOrder('id')]);
        final snapshot = await _storeFavorite.find(_database!, finder: finder);
        return snapshot.map((e) => e.value.toString()).toList();
      case 'cart':
        final finder =
            Finder(sortOrders: [SortOrder('priority'), SortOrder('id')]);
        final snapshot = await _storeCart.find(_database!, finder: finder);
        return snapshot.map((e) => e.value.toString()).toList();
      default:
        return [];
    }
  }
}
