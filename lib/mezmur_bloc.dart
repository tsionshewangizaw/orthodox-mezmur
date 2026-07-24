import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'mezmur_model.dart';

// Events
abstract class MezmurEvent extends Equatable {
  const MezmurEvent();

  @override
  List<Object?> get props => [];
}

class LoadMezmurs extends MezmurEvent {
  const LoadMezmurs();
}

class FilterByCategory extends MezmurEvent {
  final String category;
  const FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SelectMezmur extends MezmurEvent {
  final MezmurModel mezmur;
  const SelectMezmur(this.mezmur);

  @override
  List<Object?> get props => [mezmur];
}

class ToggleFavorite extends MezmurEvent {
  final String mezmurId;
  const ToggleFavorite(this.mezmurId);

  @override
  List<Object?> get props => [mezmurId];
}

class SearchMezmurs extends MezmurEvent {
  final String query;
  const SearchMezmurs(this.query);

  @override
  List<Object?> get props => [query];
}

// States
abstract class MezmurState extends Equatable {
  const MezmurState();

  @override
  List<Object?> get props => [];
}

class MezmurInitial extends MezmurState {
  const MezmurInitial();
}

class MezmurLoading extends MezmurState {
  const MezmurLoading();
}

class MezmurLoaded extends MezmurState {
  final List<MezmurModel> mezmurs;
  final List<MezmurModel> filteredMezmurs;
  final MezmurModel? selectedMezmur;
  final String? selectedCategory;

  const MezmurLoaded({
    required this.mezmurs,
    required this.filteredMezmurs,
    this.selectedMezmur,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [
    mezmurs,
    filteredMezmurs,
    selectedMezmur,
    selectedCategory,
  ];

  MezmurLoaded copyWith({
    List<MezmurModel>? mezmurs,
    List<MezmurModel>? filteredMezmurs,
    MezmurModel? selectedMezmur,
    String? selectedCategory,
  }) {
    return MezmurLoaded(
      mezmurs: mezmurs ?? this.mezmurs,
      filteredMezmurs: filteredMezmurs ?? this.filteredMezmurs,
      selectedMezmur: selectedMezmur ?? this.selectedMezmur,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class MezmurError extends MezmurState {
  final String message;
  const MezmurError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class MezmurBloc extends Bloc<MezmurEvent, MezmurState> {
  MezmurBloc() : super(const MezmurInitial()) {
    on<LoadMezmurs>(_onLoadMezmurs);
    on<FilterByCategory>(_onFilterByCategory);
    on<SelectMezmur>(_onSelectMezmur);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchMezmurs>(_onSearchMezmurs);
  }

  void _onLoadMezmurs(LoadMezmurs event, Emitter<MezmurState> emit) {
    emit(const MezmurLoading());
    try {
      final mezmurs = MezmurModel.mockMezmurList;
      emit(MezmurLoaded(
        mezmurs: mezmurs,
        filteredMezmurs: mezmurs,
      ));
    } catch (e) {
      emit(MezmurError('መዝሙሮችን መጫን አልተቻለም: $e'));
    }
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<MezmurState> emit) {
    if (state is MezmurLoaded) {
      final currentState = state as MezmurLoaded;
      final filteredMezmurs = currentState.mezmurs
          .where((mezmur) => mezmur.category == event.category)
          .toList();
      emit(currentState.copyWith(
        filteredMezmurs: filteredMezmurs,
        selectedCategory: event.category,
      ));
    }
  }

  void _onSelectMezmur(SelectMezmur event, Emitter<MezmurState> emit) {
    if (state is MezmurLoaded) {
      final currentState = state as MezmurLoaded;
      emit(currentState.copyWith(selectedMezmur: event.mezmur));
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<MezmurState> emit) {
    if (state is MezmurLoaded) {
      final currentState = state as MezmurLoaded;
      final updatedMezmurs = currentState.mezmurs.map((mezmur) {
        if (mezmur.id == event.mezmurId) {
          return mezmur.copyWith(isFavorite: !mezmur.isFavorite);
        }
        return mezmur;
      }).toList();

      final updatedFiltered = currentState.filteredMezmurs.map((mezmur) {
        if (mezmur.id == event.mezmurId) {
          return mezmur.copyWith(isFavorite: !mezmur.isFavorite);
        }
        return mezmur;
      }).toList();

      emit(currentState.copyWith(
        mezmurs: updatedMezmurs,
        filteredMezmurs: updatedFiltered,
        selectedMezmur: currentState.selectedMezmur?.id == event.mezmurId
            ? currentState.selectedMezmur!.copyWith(
            isFavorite: !currentState.selectedMezmur!.isFavorite)
            : currentState.selectedMezmur,
      ));
    }
  }

  void _onSearchMezmurs(SearchMezmurs event, Emitter<MezmurState> emit) {
    if (state is MezmurLoaded) {
      final currentState = state as MezmurLoaded;
      if (event.query.isEmpty) {
        emit(currentState.copyWith(filteredMezmurs: currentState.mezmurs));
      } else {
        final query = event.query.toLowerCase();
        final filteredMezmurs = currentState.mezmurs.where((mezmur) {
          return mezmur.title.toLowerCase().contains(query) ||
              mezmur.artist.toLowerCase().contains(query) ||
              mezmur.category.toLowerCase().contains(query);
        }).toList();
        emit(currentState.copyWith(filteredMezmurs: filteredMezmurs));
      }
    }
  }
}