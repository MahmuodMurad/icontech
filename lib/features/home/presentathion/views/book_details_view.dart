//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icontech/features/home/presentathion/views/widgets/book_details_view_body.dart';
//
// import '../../../../core/data/models/book_model/book_model.dart';
// import '../view_model/related_books_cubit/related_books_cubit.dart';
//
// class BookDetailsView extends StatefulWidget {
//   const BookDetailsView({super.key, required this.bookModel});
//
//   final BookModel bookModel;
//   @override
//   State<BookDetailsView> createState() => _BookDetailsViewState();
// }
//
// class _BookDetailsViewState extends State<BookDetailsView> {
//   @override
//   void initState() {
//     BlocProvider.of<RelatedBooksCubit>(context).fetchRelatedBooks(
//         category: widget.bookModel.volumeInfo.categories?[0]??'');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: BookDetailsViewBody(
//           bookModel: widget.bookModel,
//         ),
//       ),
//     );
//   }
// }