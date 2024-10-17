
import 'package:get/get.dart';

import '../model/movie_list_response.dart';
import '../services/network_adapter.dart';
import '../utils/enum.dart';

class HomeController extends GetxController {
  List<MovieResult> movieList = [];
  ApiCallStatus apiCallStatus = ApiCallStatus.loading;
  String errorMessage = "";

  callApi() async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    await BaseClient.shared.safeApiCall(
      "https://hoblist.com/api/movieList",
      data: {
        "category": "movies",
        "language": "kannada",
        "genre": "all",
        "sort": "voting"
      },
      RequestType.post,
      onSuccess: (success) {
        movieList = MovieListResponse.fromJson(success.data).result;
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        error.fold(
          (l) {
            errorMessage = l;
          },
          (r) {
            errorMessage = r;
          },
        );
        update();
      },
    );
  }
}
