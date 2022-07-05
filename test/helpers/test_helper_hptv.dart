import 'package:ditonton/data/datasources/db/database_helper_hptv.dart';
import 'package:ditonton/data/datasources/hptv/hptv_local_data_source.dart';
import 'package:ditonton/data/datasources/hptv/hptv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  HptvRepository,
  HptvRemoteDataSource,
  HptvLocalDataSource,
  DatabaseHelperHptv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
