import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'data/challenge-progress-repository.dart';
import 'domain/app-state.dart';
import 'domain/challenge.dart';

class StateContainer extends StatefulWidget {
  final AppState state;
  final ChallengeProgressRepository challengeProgressRepository;
  final Widget child;

  StateContainer({
    @required this.child,
    @required this.challengeProgressRepository,
    this.state,
  });

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  State<StatefulWidget> createState() {
    return StateContainerState();
  }
}

class StateContainerState extends State<StateContainer> {
  AppState state;

  @override
  void initState() {
    debugPrint("Initialising empty AppState");
    state = AppState();
    widget.challengeProgressRepository.loadAll().then((challengeProgress) {
      debugPrint("Got challenge progress from DB, replacing AppState");
      setState(() {
        state = AppState(
            challenges: challengeProgress
                .asMap()
                .map((i, c) => MapEntry(c.name, Challenge.fromEntity(c))));
      });
    });

    super.initState();
  }

  void updateChallengeProgress(
    Challenge challenge, {
    int score,
    bool complete,
    String state,
  }) {
    debugPrint("setState in AppState container (challenge updated)");
    setState(() {
      challenge.score = score ?? challenge.score;
      challenge.completed = complete ?? challenge.completed;
      challenge.state = state ?? challenge.state;
    });

    widget.challengeProgressRepository.update(challenge.toEntity());
  }

//  @override
//  void setState(VoidCallback fn) {
//    super.setState(fn);
//  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
