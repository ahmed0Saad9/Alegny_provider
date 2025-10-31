// import 'package:equatable/equatable.dart';
// import 'package:Alegny_provider/src/data/models/pagination.dart';
//
//
// enum ErrorType {
//    serverSideError,
//    networkConnectionError,
//    dataEmptyError,
//    unKnownError,
// }
//
//
//
// class ErrorModel{
//   ErrorType? errorType;
//   String? errorTitle;
//   ErrorModel({this.errorType,this.errorTitle});
// }
//
//
//
//
// abstract class DataState<T> extends Equatable{
//   final T? data;
//   final T? searchData;
//   final Pagination? pagination;
//   final ErrorModel? error;
//
//   @override
//   String toString() {
//     return 'DataState{data: $data, pagination: $pagination, error: $error}';
//   }
//   const DataState({this.data,this.pagination,this.error,this.searchData});
// }
//
// class DataSuccess<T> extends DataState<T> {
//   const DataSuccess(T data,{T? searchData,Pagination? pagination}) : super(data: data, pagination: pagination,searchData: searchData);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [data,searchData,pagination];
// }
// class DataFailed<T> extends DataState<T> {
//   const DataFailed(ErrorModel error) : super(error:error);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [error];
// }
// class DataInitial extends DataState {
//   const DataInitial() : super();
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
// class DataLoading extends DataState {
//   const DataLoading() : super();
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
//
// class DataDump extends DataState {
//   const DataDump() : super();
//
//   @override
//   // TODO: implement props
//   List<Object?> get props =>[];
// }
//
//
// class DataSearchLoading extends DataState {
//   const DataSearchLoading() : super();
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
//
