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
            return const Center(
              child: Text(
                "Nous n'avons rien 🤔",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is WikiLoaded) {
            return SearchGoodBody(
              title: state.wiki.titre,
              body: state.wiki.desc,
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

class SearchGoodBody extends StatefulWidget {
  const SearchGoodBody({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  State<SearchGoodBody> createState() => _SearchGoodBodyState();
}

class _SearchGoodBodyState extends State<SearchGoodBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListerner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Text(
                widget.body,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _scrollController.offset > 500
          ? FloatingActionButton(
              mini: true,
              onPressed: _jumpToTop,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListerner() {
    if (_scrollController.offset > 400 && _scrollController.offset < 600) {
      setState(() {});
    }
  }

  void _jumpToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }
}
