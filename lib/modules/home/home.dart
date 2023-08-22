import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../history/history.dart';
import '../tts/bloc/tts_bloc.dart';
import '../wiki/bloc/wiki_bloc.dart';
import 'components/floating_action.dart';
import 'components/search_body.dart';
import 'components/search_field.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WikiBloc(),
        ),
        BlocProvider(
          create: (context) => TtsBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: user.photoURL != null ? Image.network(user.photoURL!) : null,
          title: const Text("Land Wiki"),
          centerTitle: true,
          actions: [
            IconButton.filledTonal(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ));
                },
                icon: const Icon(
                  Icons.history,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchField(),
              const SizedBox(
                height: 10,
              ),
              const SearchBody(),
            ],
          ),
        ),
        floatingActionButton: FloatingAction(tts: tts),
      ),
    );
  }
}
