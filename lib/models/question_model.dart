class QuestionModel{

  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  bool answered;

  QuestionModel({
    this.correctOption,
    this.question,
    this.answered,
    this.option1,
    this.option4,
    this.option3,
    this.option2
  });
}