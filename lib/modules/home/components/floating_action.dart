import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../tts/bloc/tts_bloc.dart';
import '../../wiki/bloc/wiki_bloc.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({
    super.key, required this.tts,
  });

  final FlutterTts tts;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TtsBloc, TtsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        print(state);
        if (state is TtsInitial || state is TtsFinished) {
          return _buildBlocNoSpeak();
        }

        if (state is TtsError) {
          return FloatingActionButton.extended(
              onPressed: () => context.read<TtsBloc>().add(StopTts(tts: tts)),
              label: Text(state.message));
        } else {
          return _buildFloatIsSpeaking(context);
        }
      },
    );
  }

  FloatingActionButton _buildFloatIsSpeaking(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read<TtsBloc>().add(StopTts(tts: tts)),
      child: const Icon(
        Icons.stop,
        size: 35,
      ),
    );
  }

  BlocBuilder<WikiBloc, WikiState> _buildBlocNoSpeak() {
    return BlocBuilder<WikiBloc, WikiState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is WikiLoaded) {
          return _buildFloatingWikiLoaded(context, state);
        }
        return const SizedBox();
      },
    );
  }

  FloatingActionButton _buildFloatingWikiLoaded(
      BuildContext context, WikiLoaded state) {
    return FloatingActionButton(
      onPressed: () => context.read<TtsBloc>().add(
            StartTts(
              text: state.wiki.desc,
              tts: tts,
            ),
          ),
      child: const Icon(
        Icons.play_arrow,
        size: 35,
      ),
    );
  }
}
