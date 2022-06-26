import 'package:bloc/bloc.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/usecases/get_resources_usecase.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_events.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final GetResourcesUsecase _fetchUsecase;

  ResourceBloc(this._fetchUsecase) : super(const ResourceState()) {
    on<ResourceFetchedEvent>(_onPostFetched);
  }

  void _onPostFetched(
      ResourceFetchedEvent event, Emitter<ResourceState> emit) async {
    try {
      final resources = await _fetchUsecase();
      return emit(
        state.copyWith(
          status: ResourceStatus.success,
          resources: resources,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ResourceStatus.failure));
    }
  }
}
