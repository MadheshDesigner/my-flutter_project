import '../../../utils/constant.dart';
import 'package:dio/dio.dart';

class ApiService{
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstant.BASEURL,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<dynamic> getApiData()async{
    try{
      final response = await dio.get(AppConstant.GETLISTURL);
      if(response.statusCode==200){
       return  response.data;
      }else{
        return null;
      }
    }
    on DioException catch(e){
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout");
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw Exception("Page Not Found");
        } else if (statusCode == 500) {
          throw Exception("Internal Server Error");
        } else {
          throw Exception("Something went wrong");
        }
      } else if (e.type == DioExceptionType.unknown) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Unexpected Error");
      }
      }catch(e){
      throw Exception("Unexpected Error: $e");
    }
    }

}