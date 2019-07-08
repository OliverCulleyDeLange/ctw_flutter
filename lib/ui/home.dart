import 'dart:math';

import 'package:ctw_flutter/domain/home-models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(builder: (context, model, child) {
      var _challengeTiles = model.challengeTiles
          .map((tile) => tile.get(context, tile.title))
          .toList();
      var _menuTiles =
      model.menuTiles.map((tile) => tile.get(context)).toList();
      var _allTiles = _challengeTiles;
      for (var i = 0; i < _menuTiles.length; i++) {
        var insertIndex =
            model.gridRowSize * (i + 1) + (i * Random().nextInt(3));
        if (_allTiles.length > insertIndex) {
          _allTiles.insert(insertIndex, _menuTiles[i]);
        } else {
          _allTiles.add(_menuTiles[i]);
        }
      }

      return Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
                crossAxisCount: model.gridRowSize, children: _allTiles),
          ),
          Slider(
            value: model.gridRowSize.toDouble(),
            onChanged: (double value) {
              model.setGridRowSize(value);
            },
            max: 5,
            min: 3,
          )
        ],
      );
    });
  }
}
