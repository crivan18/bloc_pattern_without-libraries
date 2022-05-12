import 'package:flutter/material.dart';

import '../blocs/catalog/catalog_bloc.dart';
import '../blocs/catalog/catalog_event.dart';
import '../models/item_model.dart';

import 'package:bloc_pattern_sin_librerias/utils/hex_to_color.dart';
import 'package:bloc_pattern_sin_librerias/items/items.dart' as sample_data;

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final CatalogBloc _catalogBloc = CatalogBloc();

  @override
  void initState() {
    super.initState();
    _catalogBloc.sendEvent.add(GetCatalogEvent());
  }

  @override
  void dispose() {
    _catalogBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pushNamed(context, '/user');
          },
        ),
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_basket),
                Positioned(
                  right: -10,
                  top: -10,
                  child: CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    child: StreamBuilder<List<ItemModel>>(
                      initialData: const [],
                      stream: _catalogBloc.catalogStream,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data?.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        );
                      },
                    ),
                    radius: 10.0,
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          )
        ],
      ),
      body: Center(
        child: ListViewWidget(_catalogBloc),
      ),
    );
  }
}

class ListViewWidget extends StatefulWidget {
  final CatalogBloc _catalogBloc;

  const ListViewWidget(this._catalogBloc, {Key? key}) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final List<ItemModel> items = [];

  @override
  void initState() {
    super.initState();

    for (Map<String, dynamic> element in sample_data.listItems) {
      items.add(
        ItemModel(
          id: element['id'],
          name: element['name'],
          color: element['color'],
          pantoneValue: element['pantone_value'],
          price: element['price'],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: hexToColor(items[index].color),
            ),
          ),
          title: Text(items[index].name.toUpperCase()),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[index].pantoneValue),
              Text(
                '\$${items[index].price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: items[index].addedToCart
                ? const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
            onPressed: () {
              if (items[index].addedToCart) {
                widget._catalogBloc.sendEvent.add(
                  RemoveCatalogItemEvent(items[index]),
                );
              } else {
                widget._catalogBloc.sendEvent.add(
                  AddCatalogItemEvent(items[index]),
                );
              }

              setState(() {
                items[index].toggleAdded();
              });
            },
          ),
        ),
      ),
    );
  }
}
