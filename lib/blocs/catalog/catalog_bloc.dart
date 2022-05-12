import 'dart:async';

import '../../models/item_model.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc {
  final CatalogState _catalogState = CatalogState();

  final StreamController<CatalogEvent> _input = StreamController();
  // El output va a ser escuchado desde cualquier parte de la ui
  final StreamController<List<ItemModel>> _output =
      StreamController.broadcast();

  StreamSink<CatalogEvent> get sendEvent => _input.sink;

  Stream<List<ItemModel>> get catalogStream => _output.stream;

  CatalogBloc() {
    _input.stream.listen(_onEvent);
  }

  void _onEvent(CatalogEvent event) {
    if (event is AddCatalogItemEvent) {
      _catalogState.addToCatalog(event.item);
    } else if (event is RemoveCatalogItemEvent) {
      _catalogState.removeFromCatalog(event.item);
    }

    _output.add(_catalogState.catalog);
  }

  void dispose() {
    _input.close();
    _output.close();
  }
}
