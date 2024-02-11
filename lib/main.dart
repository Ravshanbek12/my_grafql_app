import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_grafql_app/anime.dart';
import 'package:my_grafql_app/search_country.dart';

import 'graphql_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = GraphQLService();
  runApp(
    MyApp(
      client: ValueNotifier(service.client()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final ValueNotifier<GraphQLClient>? client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimeListPage()


        // Scaffold(
        //   body: Center(
        //     child: Text("Hello World"),
        //   ),
        // ),
      ),
    );
  }
}
