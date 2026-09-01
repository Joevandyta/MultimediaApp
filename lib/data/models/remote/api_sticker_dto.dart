/// Data Transfer Object for a single sticker from the remote API.
class ApiStickerDto {
  const ApiStickerDto({
    required this.id,
    required this.title,
    required this.image,
    required this.width,
    required this.height,
    required this.slug,
    required this.username,
  });

  final String id;
  final String title;
  final String image;
  final int width;
  final int height;
  final String slug;
  final String username;

  factory ApiStickerDto.fromJson(Map<String, dynamic> json) {
    return ApiStickerDto(
      id: json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  }
}
