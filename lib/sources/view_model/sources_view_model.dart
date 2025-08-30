import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/service_locator.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/repository/sources_repository.dart';
import 'package:news_app/sources/view_model/sources_states.dart';

class SourcesViewModel extends Cubit<SourcesState> {
  late SourcesRepository sourcesRepository;

  SourcesViewModel() : super(SourcesInitial()) {
    sourcesRepository = SourcesRepository(ServiceLocator.sourcesDataSource);
  }
  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoading());
    try {
      List<Source> sources = await sourcesRepository.getSources(categoryId);
      emit(GetSourcesSuccess(sources));
    } catch (error) {
      emit(GetSourcesError(error.toString()));
    }
  }
}
