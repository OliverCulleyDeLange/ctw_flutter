import 'dart:math';

import 'package:ctw_flutter/bloc/challenge-bloc.dart';
import 'package:ctw_flutter/data/challenge-progress.dart';
import 'package:ctw_flutter/domain/home-models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var challengeProgressBloc = Provider.of<ChallengeProgressBloc>(context);
    return StreamBuilder(
      stream: challengeProgressBloc.challenges,
      builder: (BuildContext context,
          AsyncSnapshot<List<ChallengeProgress>> challengeProgress) {
        debugPrint(
            "DB Stream: ${challengeProgress.data?.map((c) => "${c.id}:${c
                .name} - ${c
                .completed}")}");

        return Consumer<HomeViewModel>(builder: (context, viewModel, child) {
          var _challengeTiles = viewModel.challengeTiles
              .map((tile) => tile.get(context, tile.title))
              .toList();
          var _menuTiles =
          viewModel.menuTiles.map((tile) => tile.get(context)).toList();
          var _allTiles = _challengeTiles;
          for (var i = 0; i < _menuTiles.length; i++) {
            var insertIndex =
                viewModel.gridRowSize * (i + 1) + (i * Random().nextInt(3));
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
                    crossAxisCount: viewModel.gridRowSize, children: _allTiles),
              ),
              Slider(
                value: viewModel.gridRowSize.toDouble(),
                onChanged: (double value) {
                  viewModel.setGridRowSize(value);
                },
                max: 5,
                min: 3,
              )
            ],
          );
        });
      },
    );
  }
}
