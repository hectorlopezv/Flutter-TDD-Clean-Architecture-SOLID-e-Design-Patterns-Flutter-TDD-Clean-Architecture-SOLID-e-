abstract class HttpClientDemo<ResponseType> {
  Future<dynamic> request(
      {
        required String url, 
        required String method, 
        Map? body,
        Map? headers
      });
}
