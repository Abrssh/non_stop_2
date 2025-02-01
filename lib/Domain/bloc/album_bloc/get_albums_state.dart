part of 'get_albums_bloc.dart';

class GetAlbumsState extends Equatable {
  final List<Album> albumsList;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  const GetAlbumsState({
    this.albumsList = const [],
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
  });

  GetAlbumsState copyWith({
    List<Album>? albumsList,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return GetAlbumsState(
      albumsList: albumsList ?? this.albumsList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [albumsList, isLoading, errorMessage, isError];
}
