import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:music_dictionary/data/models/app_content_model.dart';
import 'package:music_dictionary/data/models/chord_model.dart';
import 'package:music_dictionary/shared/constants/firebase_keys.dart';
import 'package:music_dictionary/shared/core/failure.dart';

abstract class MusicDictionaryDatasource {
  Future<Either<Failure, List<AppContentModel>>> fetchHomePage();
  Future<Either<Failure, List<ChordModel>>> fetchChordsPage();
}

class MockMusicDictionaryDatasource implements MusicDictionaryDatasource {
  @override
  Future<Either<Failure, List<AppContentModel>>> fetchHomePage() async {
    await Future.delayed(Duration(seconds: 2));
    return Right([
      AppContentModel(name: 'Acordes', path: '/chords'),
      AppContentModel(name: 'Escalas', path: '/scales')
    ]);
  }

  @override
  Future<Either<Failure, List<ChordModel>>> fetchChordsPage() async {
    await Future.delayed(Duration(seconds: 2));
    return Right([
      ChordModel(name: 'A', images: ['img1'], description: 'description'),
      ChordModel(name: 'B', images: ['img1'], description: 'description'),
    ]);
  }
}

class FirestoreMusicDictionaryDatasource implements MusicDictionaryDatasource {
  FirestoreMusicDictionaryDatasource({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<Either<Failure, List<AppContentModel>>> fetchHomePage() async {
    try {
      List<AppContentModel> homePageData = [];
      final response = await firestore
          .collection(FirebaseKeys.homePageCollection)
          .doc(FirebaseKeys.homePageContents)
          .get();
      final List array = response.data()?[FirebaseKeys.contents];
      array.forEach((e) => homePageData.add(AppContentModel.fromMap(e)));
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
  Future<Either<Failure, List<ChordModel>>> fetchChordsPage() async {
    try {
      List<ChordModel> chordsPageData = [];
      final response = await firestore
          .collection(FirebaseKeys.chordsPageCollection)
          .doc(FirebaseKeys.chordsPageContents)
          .get();
      final List array = response.data()?[FirebaseKeys.contents];
      array.forEach((e) => chordsPageData.add(ChordModel.fromMap(e)));
      return Right(chordsPageData);
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
