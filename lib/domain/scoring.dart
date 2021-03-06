abstract class Scorer {
  const Scorer();

  StarScore getStarScore(Duration timeToComplete);
}

class TimeScorer extends Scorer {
  final List<Duration> starThresholds;

  const TimeScorer._fromThreshold(this.starThresholds);

  static const TimeScorer fastThreeStar =
      TimeScorer._fromThreshold([Duration(seconds: 10), Duration(seconds: 20)]);

  @override
  StarScore getStarScore(Duration timeToComplete) {
    var maxStars = starThresholds.length + 1;
    for (int i = 0; i < starThresholds.length; i++) {
      if (timeToComplete.compareTo(starThresholds[i]) <= 0) {
        return StarScore(maxStars - i, maxStars);
      }
    }
    return StarScore(1, maxStars);
  }
}

class StarScore {
  int get stars => _score;

  int get emptyStars => _outOf - _score;

  int _score;
  int _outOf;

  @override
  String toString() => "$_score/$_outOf";

  StarScore(this._score, this._outOf)
      : assert(_score <= _outOf),
        assert(_score >= 0);
}
