import 'package:studyse/model/courses.dart';
import 'package:studyse/network_utils/api.dart';

Future<List<Courses>> fetchCourses() async {
    String url = "/courses";
    final response = await Network().getData(url);
    return coursesFromJson(response.body);
}