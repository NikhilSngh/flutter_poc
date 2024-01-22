import 'package:flutter_poc/constant/app_constant.dart';
import 'package:flutter_poc/data/network/api_client.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/sl/locator.dart';


class HomeRepository {
  late ApiClient _apiService;

  HomeRepository() {
    _apiService = serviceLocator.get<ApiClient>();
  }

  Future<MovieListModel> getMoviesData(int pageNo) async {
    final response = await _apiService.getDataFromApi(
        endpoint: ApiUrl.GET_MOVIES,
        converter: MovieListModel.fromJson,
        queryParams: {"api_key": AppConstant.API_KEY, "page": pageNo});
    return response;
  }
}
