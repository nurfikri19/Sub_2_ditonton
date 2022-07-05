import 'dart:convert';

import 'package:ditonton/data/models/hptv/hptv_detail_model.dart';
import 'package:ditonton/data/models/hptv/hptv_model.dart';
import 'package:ditonton/data/models/hptv/hptv_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class HptvRemoteDataSource {
  Future<List<HptvModel>> getNowPlayingTv();
  Future<List<HptvModel>> getPopularTv();
  Future<List<HptvModel>> getTopRatedTv();
  Future<HptvDetailResponse> getTvDetail(int id);
  Future<List<HptvModel>> getTvRecommendations(int id);
  Future<List<HptvModel>> searchTv(String query);
}

class HptvRemoteDataSourceImpl implements HptvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  HptvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HptvModel>> getNowPlayingTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return HptvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HptvDetailResponse> getTvDetail(int id) async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return HptvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<HptvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return HptvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<HptvModel>> getPopularTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return HptvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<HptvModel>> getTopRatedTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return HptvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<HptvModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return HptvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
