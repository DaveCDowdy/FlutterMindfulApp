import 'package:flutter/material.dart';
import '../data/quote.dart';
import '../data/db_helper.dart';

class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({super.key});

  @override
  State<QuotesListScreen> createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  List<Quote>? _quotes;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    DbHelper helper = DbHelper();
    final data = await helper.getQuotes();
    setState(() {
      _quotes = data.where((q) => q.text.isNotEmpty).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Quotes'), centerTitle: false),
      body: Container(color: Theme.of(context).focusColor, child: _buildList()),
    );
  }

  Widget _buildList() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_quotes == null || _quotes!.isEmpty) {
      return const Center(child: Text('No favorite quotes yet.'));
    }

    return ListView.builder(
      itemCount: _quotes!.length,
      itemBuilder: (context, index) {
        final quote = _quotes![index];

        return Dismissible(
          key: ValueKey(quote.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            DbHelper().deleteQuote(quote.id!);

            setState(() {
              _quotes!.removeAt(index);
            });

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Quote deleted')));
          },
          child: ListTile(
            title: Text(quote.text),
            subtitle: Text(quote.author),
          ),
        );
      },
    );
  }
}
