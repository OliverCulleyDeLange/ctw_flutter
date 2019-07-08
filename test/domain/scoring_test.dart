import 'package:ctw_flutter/domain/scoring.dart';
import 'package:test/test.dart';

void main() {
  final scorer = TimeScorer.fastThreeStar;
  final testData = [
    {'score': -1, 'expectedStars': 3, 'expectedEmpty': 0},
    {'score': 0, 'expectedStars': 3, 'expectedEmpty': 0},
    {'score': 1, 'expectedStars': 3, 'expectedEmpty': 0},
    {'score': 10, 'expectedStars': 3, 'expectedEmpty': 0},
    {'score': 11, 'expectedStars': 2, 'expectedEmpty': 1},
    {'score': 20, 'expectedStars': 2, 'expectedEmpty': 1},
    {'score': 21, 'expectedStars': 1, 'expectedEmpty': 2},
  ];
  testData.forEach((data) {
    test('TimeScorer.fastThreeStar gives ${data['expectedStars']} rating', () {
      var score = scorer.getStarScore(Duration(seconds: data['score']));
      expect(score.stars, data['expectedStars']);
      expect(score.emptyStars, data['expectedEmpty']);
    });
  });
}
