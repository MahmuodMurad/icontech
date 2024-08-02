//
// import 'package:dartz/dartz.dart';
//
// import 'package:dio/dio.dart';
//
// import '../../../../core/data/models/book_model/book_model.dart';
// import '../../../../core/errors/failure.dart';
// import '../../../../core/utils/api_service.dart';
// import 'home_repo.dart';
//
// class HomeRepoImpl implements HomeRepo {
//   final ApiService apiService;
//
//   HomeRepoImpl(this.apiService);
//   @override
//   Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
//     try {
//       var data = await apiService.get(
//           endPoint:
//           'volumes?Filtering=free-ebooks&Sorting=newest &q=coding');
//       List<BookModel> books = [];
//       for (var item in data['items']) {
//         try {
//           books.add(BookModel.fromJson(item));
//         } catch (e) {
//           books.add(BookModel.fromJson(item));
//         }
//       }
//
//       return right(books);
//     } catch (e) {
//       if (e is DioException) {
//         return left(
//           ServerFailure.fromDioError(e),
//         );
//       }
//       return left(
//         ServerFailure(
//           e.toString(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, List<BookModel>>> fetchMainBooks() async {
//     try {
//       var data = await apiService.get(
//           endPoint: 'volumes?Filtering=free-ebooks&q=subject:flutter');
//       List<BookModel> books = [];
//       for (var item in data['items']) {
//         books.add(BookModel.fromJson(item));
//       }
//
//       return right(books);
//     } catch (e) {
//       if (e is DioException) {
//         return left(
//           ServerFailure.fromDioError(e),
//         );
//       }
//       return left(
//         ServerFailure(
//           e.toString(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, List<BookModel>>> fetchRelatedBooks(
//       {required String category}) async {
//     try {
//       var data = await apiService.get(
//           endPoint:
//           'volumes?Filtering=free-ebooks&Sorting=relevance &q=subject:Programming');
//       List<BookModel> books = [];
//       for (var item in data['items']) {
//         books.add(BookModel.fromJson(item));
//       }
//
//       return right(books);
//     } catch (e) {
//       if (e is DioException) {
//         return left(
//           ServerFailure.fromDioError(e),
//         );
//       }
//       return left(
//         ServerFailure(
//           e.toString(),
//         ),
//       );
//     }
//   }
// }