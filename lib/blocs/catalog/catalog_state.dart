import '../../models/item_model.dart';

class CatalogState {
  final List<ItemModel> _catalog = [];

  CatalogState._();

  static final CatalogState _instance = CatalogState._();
  factory CatalogState() => _instance;

  List<ItemModel> get catalog => _catalog;

  void addToCatalog(ItemModel itemModel) {
    _catalog.add(itemModel);
  }

  void removeFromCatalog(ItemModel itemModel) {
    _catalog.remove(itemModel);
  }
}
