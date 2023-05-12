import 'package:bloc_quiz/data/model/questions.dart';

/// This class is used to create quiz from given `JSON` data
/// `populateList(json)` must be called before using any methods
class PrepareQuiz {
  List<Question> _questionList = [];

  List<String> _createOptions(dynamic json, int i) {
    List<String> list = (json[i]['incorrectAnswers']).cast<String>();
    list.add(json[i]['correctAnswer']);

    list.shuffle();

    return list;
  }

  int getCorrectIndex(int i) {
    for (int j = 0; j < 4; j++) {
      if (_questionList[i].options[j] == _questionList[i].correctAnswer) {
        return j;
      }
    }
    return 0;
  }

  void populateList(dynamic json) {
    for (int i = 0; i < 10; i++) {
      _questionList.add(Question(
        question: json[i]['question'],
        correctAnswer: json[i]['correctAnswer'],
        options: _createOptions(json, i),
      ));
    }
  }

  String getQuestion(int i) {
    return _questionList[i].question;
  }

  List<String> getOptions(int i) {
    return _questionList[i].options;
  }

  bool isCorrect(int i, int selectedOption) {
    if (_questionList[i].options[selectedOption] ==
        _questionList[i].correctAnswer) return true;
    return false;
  }
}
