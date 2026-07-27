import 'package:isar_community/isar.dart';
import 'package:multimedia_sticker_maker/data/datasources/local/local_data_sources.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_model.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/data/repositories/sticker_repository_impl.dart';
import 'package:multimedia_sticker_maker/domain/repositories/sticker_repository.dart';
import 'package:multimedia_sticker_maker/domain/usecases/sticker_usecase.dart';
import 'package:multimedia_sticker_maker/domain/usecases/sticker_usecase_impl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
Future<Isar> isar(Ref ref) async {
  final dir = await getApplicationCacheDirectory();
  if (Isar.instanceNames.contains('db')) {
    return Isar.getInstance('db')!;
  }
  return await Isar.open([StickerModelSchema, StickerPackSchema], directory: dir.path, name: 'db');
}

@riverpod
Future<LocalDataSource> localDataSource(Ref ref) async {
  final isar = await ref.watch(isarProvider.future);
  return LocalDataSource(isar: isar);
}

@riverpod
Future<StickerRepository> stickerRepository(Ref ref) async {
  final localDataSource = await ref.watch(localDataSourceProvider.future);
  return StickerRepositoryImpl(localDataSource: localDataSource);
}

@riverpod
Future<StickerUseCase> stickerUseCase(Ref ref) async {
  final repository = await ref.watch(stickerRepositoryProvider.future);
  return StickerUseCaseImpl(repository: repository);
}
