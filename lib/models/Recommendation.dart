class Recommendation {
  String? studentId;
  String? message;
  String? id;
  final List<Map<String, dynamic>> recommendations;

  Recommendation({this.message, required this.studentId, required this.recommendations, this.id});


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
