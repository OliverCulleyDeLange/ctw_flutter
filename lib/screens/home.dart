import 'package:ctw_flutter/domain/home-models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
        builder: (context, model, child) =>
            GridView.count(
                crossAxisCount: 4,
                children: model.challengeTiles.values
                    .map((tile) => tile.get(context, tile.title))
                    .toList()));
  }
}
