import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_web_complex_list/repository.dart';
import 'package:flutter_web_complex_list/models/models.dart';
import 'package:flutter_web_complex_list/bloc/bloc.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final Repository repository;

  ListBloc({@required this.repository});

  @override
  ListState get initialState => Loading();

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    if (event is Fetch) {
      try {
        final items = await repository.fetchItems();
        yield Loaded(items: items);
      } catch (_) {
        yield Failure();
      }
    }
    if (event is Delete) {
      final listState = currentState;
      if (listState is Loaded) {
        final List<Item> updatedItems =
            List<Item>.from(listState.items).map((Item item) {
          return item.id == event.id ? item.copyWith(isDeleting: true) : item;
        }).toList();
        yield Loaded(items: updatedItems);
        repository.deleteItem(event.id).listen((id) {
          dispatch(Deleted(id: id));
        });
      }
    }
    if (event is Deleted) {
      final listState = currentState;
      if (listState is Loaded) {
        final List<Item> updatedItems = List<Item>.from(listState.items)
          ..removeWhere((item) => item.id == event.id);
        yield Loaded(items: updatedItems);
      }
    }
  }
}
