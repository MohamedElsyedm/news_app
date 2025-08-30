import 'package:news_app/sources/data/models/source.dart';

abstract class SourcesState {}

class SourcesInitial extends SourcesState {}

class GetSourcesLoading extends SourcesState {}

class GetSourcesError extends SourcesState {
  String message;
  GetSourcesError(this.message);
}

class GetSourcesSuccess extends SourcesState {
  List<Source> sources;
  GetSourcesSuccess(this.sources);
}
