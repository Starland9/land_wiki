import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../wiki/bloc/wiki_bloc.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WikiBloc, WikiState>(
        builder: (context, state) {
          if (state is WikiInitial) {
            return const Center(
              child: Text("Fait une recherche pour voir"),
            );
          }
          if (state is WikiError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
          if (state is WikiLoaded) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      state.wiki.titre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Text(state.wiki.desc),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 5,
                ),
                Text("Le wiki cherche...")
              ],
            ),
          );
        },
      ),
    );
  }
}
