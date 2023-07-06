import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../wiki/bloc/wiki_bloc.dart';

class SearchField extends StatelessWidget {
  final _controller = TextEditingController();

  SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WikiBloc, WikiState>(
      builder: (context, state) {
        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            label: const Text("Recherche un truc"),
            hintText: "ex: python3",
            suffixIcon: IconButton.filled(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ))),
              onPressed: () =>
                  context.read<WikiBloc>().add(GetWiki(text: _controller.text)),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
