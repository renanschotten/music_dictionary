import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:music_dictionary/data/models/home_page_content_model.dart';
import 'package:music_dictionary/data/models/base_content_model.dart';
import 'package:music_dictionary/shared/constants/firebase_keys.dart';
import 'package:music_dictionary/shared/core/failure.dart';

abstract class MusicDictionaryDatasource {
  Future<Either<Failure, List<HomePageContentModel>>> fetchHomePage();
  Future<Either<Failure, List<BaseContentModel>>> fetchContent({
    required String id,
  });
}

class MockMusicDictionaryDatasource implements MusicDictionaryDatasource {
  @override
  Future<Either<Failure, List<HomePageContentModel>>> fetchHomePage() async {
    await Future.delayed(Duration(seconds: 2));
    return Right([
      HomePageContentModel(name: 'Acordes', id: 'chords'),
      HomePageContentModel(name: 'Escalas', id: 'scales')
    ]);
  }

  @override
  Future<Either<Failure, List<BaseContentModel>>> fetchContent({
    required String id,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return Right([
      BaseContentModel(name: 'A', images: ['img1'], description: 'description'),
      BaseContentModel(name: 'B', images: ['img1'], description: 'description'),
    ]);
  }
}

class FirestoreMusicDictionaryDatasource implements MusicDictionaryDatasource {
  FirestoreMusicDictionaryDatasource({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<Either<Failure, List<HomePageContentModel>>> fetchHomePage() async {
    try {
      List<HomePageContentModel> homePageData = [];
      final response = await firestore
          .collection(FirebaseKeys.homePageCollection)
          .doc(FirebaseKeys.homePageContents)
          .get();
      final List array = response.data()?[FirebaseKeys.contents];
      array.forEach((e) => homePageData.add(HomePageContentModel.fromMap(e)));
      return Right(homePageData);
    } on FirebaseException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message ?? 'Erro de Conexao',
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        GenericFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BaseContentModel>>> fetchContent({
    required String id,
  }) async {
    try {
      List<BaseContentModel> baseContent = [];
      final response =
          await firestore.collection(FirebaseKeys.contents).doc(id).get();
      final List array = response.data()?[FirebaseKeys.contents];
      array.forEach((e) => baseContent.add(BaseContentModel.fromMap(e)));
      return Right(baseContent);
    } on FirebaseException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message ?? 'Erro de Conexao',
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        GenericFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
