import 'package:studyse/network_utils/api.dart';
import 'file:///C:/Users/Tneos/AndroidStudioProjects/studyse/lib/model/pages.dart';
import 'file:///C:/Users/Tneos/AndroidStudioProjects/studyse/lib/model/advertisements.dart';

Future<List<Pages>> fetchPages() async {
  String url = "/pages";
  final response = await Network().getData(url);
  return pagesFromJson(response.body);
}

Future<List<Advertisements>> fetchAdvertisement() async {
  String url = "/advertisements";
  final response = await Network().getData(url);
  return advertisementsFromJson(response.body);
}