import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:multimedia_sticker_maker/data/models/remote/api_stickers_response_dto.dart';

/// Remote data source responsible for fetching stickers from the REST API.
class RemoteStickerDataSource {
  RemoteStickerDataSource({required this.client});

  final http.Client client;

  static const String _baseUrl =
      'https://stickerify-web.vercel.app/api/stickers';

  /// Fetches a paginated, searchable list of stickers from the API.
  ///
  /// Example URL: GET /api/stickers?search=amimir&page=1&limit=12
  Future<ApiStickersResponseDto> getStickers({
    required String search,
    required int page,
    required int limit,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'search': search,
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );

    log(
      'RemoteStickerDataSource.getStickers → $uri',
      name: 'RemoteStickerDataSource',
    );

    try {
      final response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ApiStickersResponseDto.fromJson(json);
      } else {
        throw Exception(
          'API error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      log('RemoteStickerDataSource error: $e', name: 'RemoteStickerDataSource');
      rethrow;
    }
  }
}
