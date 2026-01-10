import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mindful_app/data/db_helper.dart';
import 'package:mindful_app/data/quote.dart';
import 'package:mindful_app/screens/quotes_list_screen.dart';
import 'package:mindful_app/screens/settings_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const address = 'https://zenquotes.io/api/random';
  Quote quote = Quote(text: '', author: '');

  late Future<Quote> _quoteFuture;
  @override
  void initState() {
    super.initState();
    _quoteFuture = _fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Quote'),
        actions: [
          IconButton(
            onPressed: _goToSettings,
            icon: const Icon(Icons.settings),
          ),
          IconButton(onPressed: _goToList, icon: const Icon(Icons.list)),
          IconButton(
            onPressed: () {
              setState(() {
                _quoteFuture = _fetchQuote();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<Quote>(
        future: _quoteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Theme.of(context).focusColor,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final quote = snapshot.data!;
            return Container(
              color: Theme.of(context).focusColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quote.text,
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        quote.author,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DbHelper helper = DbHelper();
          helper.insertQuote(quote).then((id) {
            final message = (id == 0) ? 'Error saving quote' : 'Quote saved';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 3),
              ),
            );
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<Quote> _fetchQuote() async {
    final Uri url = Uri.parse(address);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List quoteJson = json.decode(response.body);
      quote = Quote.fromJson(quoteJson[0]);
      return quote;
    } else {
      quote = Quote(text: 'Error retrieving quote', author: '');
      return quote;
    }
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  void _goToList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuotesListScreen()),
    );
  }
}
