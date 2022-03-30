class Recommendation {
  String studentId;
  String? message;
  final List<Map<String, String>> recommendations;

  Recommendation({this.message, required this.studentId, required this.recommendations});


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
