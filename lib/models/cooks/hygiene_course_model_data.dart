

class HygieneCoursesModelData {
  String? sId;
  String? title;
  String? description;
  String? fileType;
  String? fileUrl;
  String? filename;
  String? mimetype;
  List<Quizzes>? quizzes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  HygieneCoursesModelData(
      {this.sId,
        this.title,
        this.description,
        this.fileType,
        this.fileUrl,
        this.filename,
        this.mimetype,
        this.quizzes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  HygieneCoursesModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    fileType = json['fileType'];
    fileUrl = json['fileUrl'];
    filename = json['filename'];
    mimetype = json['mimetype'];
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(Quizzes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Quizzes {
  String? question;
  String? questionType;
  List<Options>? options;
  String? correctAnswer;
  String? sId;

  Quizzes(
      {this.question,
        this.questionType,
        this.options,
        this.correctAnswer,
        this.sId});

  Quizzes.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    questionType = json['questionType'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    correctAnswer = json['correctAnswer'];
    sId = json['_id'];
  }
}

class Options {
  String? optionText;
  bool? isCorrect;
  String? sId;

  Options({this.optionText, this.isCorrect, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    optionText = json['optionText'];
    isCorrect = json['isCorrect'];
    sId = json['_id'];
  }
}
