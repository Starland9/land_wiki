import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/history_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Historique des wiki"),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            context.read<HistoryBloc>().add(GetHistory());
            if (state is HistoryLoaded) {
              if (state.wikis.isEmpty) {
                return const Center(
                  child: Text("Aucun wiki trouvé dans la base de données"),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(state.wikis[index].titre),
                  );
                },
                separatorBuilder: (context, itemCount) =>
                    const Divider(height: 10),
                itemCount: state.wikis.length,
              );
            }

            if (state is HistoryError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.red,
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
                  Text("Chargement de l'historique en cours...")
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
