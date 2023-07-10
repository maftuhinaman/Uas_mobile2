import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListQuote extends StatelessWidget {
  final String apiUrl =
      "https://indonesia-public-static-api.vercel.app/api/volcanoes";

  const ListQuote({super.key});

  Future<List<dynamic>> _fetchListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gunung Berapi Di Indonesia'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var listTile = ListTile(
                  
                  title: Text(
                    snapshot.data[index]['nama'].toString(),
                    textAlign: TextAlign.justify,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bentuk: " + snapshot.data[index]['bentuk'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Tinggi: " + snapshot.data[index]['tinggi_meter'].toString(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Estimasi Letusan Terakhir: " + snapshot.data[index]['estimasi_letusan_terakhir'].toString(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Geolokasi: " + snapshot.data[index]['geolokasi'].toString(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                     
                    ],
                  ),
                 
                );
                return Card(
                  child: listTile,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}