class Recommendation {
  String? studentId;
  String? comment;
  String? subjectCode;
  String? teacherId;
  String? id;

  Recommendation({this.comment, required this.studentId, this.subjectCode, this.teacherId,this.id});


  /*
  factory Recommendation.fromJSON(Map<dynamic, dynamic> json) {

    List<String> sources = [];

    for(String src in json["sources"]) {
      sources.add(src);
    }

    return Recommendation(
        message: json["message"],
        studentId: json["studentId"],
        sources: sources
    );
  }

   */

}
