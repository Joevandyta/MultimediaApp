import 'package:multimedia_sticker_maker/data/models/remote/api_pagination_dto.dart';
import 'package:multimedia_sticker_maker/data/models/remote/api_sticker_dto.dart';

/// Wrapper DTO for the full sticker list response from the remote API.
class ApiStickersResponseDto {
  const ApiStickersResponseDto({
    required this.success,
    required this.stickers,
    required this.pagination,
  });

  final bool success;
  final List<ApiStickerDto> stickers;
  final ApiPaginationDto pagination;

  factory ApiStickersResponseDto.fromJson(Map<String, dynamic> json) {
    final stickersJson = json['stickers'] as List<dynamic>? ?? [];
    return ApiStickersResponseDto(
      success: json['success'] as bool? ?? false,
      stickers: stickersJson
          .map((e) => ApiStickerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: ApiPaginationDto.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
