import 'package:flutter/material.dart';

import '../blocs/catalog/catalog_bloc.dart';
import '../blocs/catalog/catalog_event.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../models/item_model.dart';
import '../utils/format_total.dart';
import '../utils/get_initials.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final UserBloc _userBloc = UserBloc();
  final CatalogBloc _catalogBloc = CatalogBloc();

  @override
  void initState() {
    super.initState();
    _userBloc.sendEvent.add(GetUsernameEvent());
    _catalogBloc.sendEvent.add(GetCatalogEvent());
  }

  @override
  void dispose() {
    _userBloc.dispose();
    _catalogBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ItemModel>>(
              initialData: const [],
              stream: _catalogBloc.catalogStream,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      snapshot.data![index].name.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '\$${snapshot.data![index].price.toStringAsFixed(2)}',
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.amberAccent,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder<String>(
                  stream: _userBloc.userStream,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        CircleAvatar(
                          child: Text(
                            getInitials('${snapshot.data}').toUpperCase(),
                          ),
                        ),
                        Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<List<ItemModel>>(
                      initialData: const [],
                      stream: _catalogBloc.catalogStream,
                      builder: (context, snapshot) {
                        return Text(
                          '\$${formatTotal(snapshot.data)}',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30.0)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
