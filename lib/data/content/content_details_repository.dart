import 'package:dio/dio.dart';

import '../endpoints.dart';
import 'content_details.dart';
import 'content_details_repository_interface.dart';

class ContentDetailsRepository implements ContentDetailsRepositoryInterface {
  ContentDetailsRepository({required this.dio});

  final Dio dio;

  @override
  Future<ContentDetails> getContentDetails(String id) async {
    try {
      // GET https://openlibrary.org/works/{id}.json
      final Response response = await dio.get(Endpoints.workById(id));

      final Map<String, dynamic> data =
          response.data as Map<String, dynamic>;

      return ContentDetails.fromWorkJson(data, id: id);
    } on DioException catch (e) {
      throw e.message ?? 'Unknown Dio error';
    } catch (e) {
      throw e.toString();
    }
  }
}
