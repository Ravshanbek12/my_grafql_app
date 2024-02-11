import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_grafql_app/refresh.dart';

import 'package:smartrefresh/smartrefresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'anime_model.dart';

class AnimeListPage extends StatefulWidget {
  const AnimeListPage({super.key});

  @override
  State<AnimeListPage> createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> {
  var animeList = <Media>[];
  final controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Cartoon'),
      ),
      body: WRefresher(
        controller: controller,
        onRefresh: () {
          setState(() {});
          controller.refreshCompleted();
        },
        child: Query(
            options: QueryOptions(
              document: gql('''
              {
  Page {
    media {
      siteUrl
      title {
        english
        native
      }
      description
    }
  }
}

              '''),
            ),
            builder: (result, {refetch, fetchMore}) {
              if (result.hasException) {
                return Center(
                  child: Text("Nimadir hato berdi!"),
                );
              }
              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(result.data);
              final medias = (result.data?['Page']['media'] as List?)
                      ?.map(
                        (media) => Media.fromJson(
                          media ?? {},
                        ),
                      )
                      .toList() ??
                  [];
              return ListView.separated(
                itemBuilder: (_, index) {
                  return ExpansionTile(
                    title: Text(
                        '${medias[index].title?.english} - ${medias[index].title?.native}'),
                    children: [
                      Row(
                        children: [
                          const Text('Website: '),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () async{
                                const url = 'https://blog.logrocket.com';
                                if(await canLaunch(url)){
                                  await launch(url);
                                }else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Text('${medias[index].siteUrl}')),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("${medias[index].description}"),
                    ],
                  );
                },
                separatorBuilder: (_, __) => SizedBox(
                  height: 12,
                ),
                itemCount: medias.length,
              );
            }),
      ),
    );
  }
}
