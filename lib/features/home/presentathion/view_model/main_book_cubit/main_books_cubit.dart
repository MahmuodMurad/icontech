//
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/data/models/book_model/book_model.dart';
// import '../../../data/repos/home_repo.dart';
//
// part 'main_books_state.dart';
//
// class MainBooksCubit extends Cubit<MainBooksState> {
//   MainBooksCubit(this.homeRepo) : super(MainBooksInitial());
//
//   final HomeRepo homeRepo;
//
//   Future<void> fetchMainBooks() async {
//     emit(MainBooksLoading());
//     var result = await homeRepo.fetchMainBooks();
//     result.fold((failure) {
//       emit(MainBooksFailure(failure.errMessage));
//     }, (books) {
//       emit(MainBooksSuccess(books));
//     });
//   }
// }