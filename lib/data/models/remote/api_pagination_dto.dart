/// Data Transfer Object for pagination metadata from the remote API.
class ApiPaginationDto {
  const ApiPaginationDto({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final int total;
  final int page;
  final int limit;
  final int totalPages;

  factory ApiPaginationDto.fromJson(Map<String, dynamic> json) {
    return ApiPaginationDto(
      total: json['total'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 12,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }
}
