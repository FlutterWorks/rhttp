// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:rhttp/rhttp.dart';
import 'package:rhttp_example/widgets/response_card.dart';

Future<void> main() async {
  await Rhttp.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HttpTextResponse? response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  try {
                    final res = await Rhttp.get(
                      'http://example.com:3000',
                      settings: const ClientSettings(
                        dnsSettings: DnsSettings(
                          overrides: {
                            'example.com': ['127.0.0.1'],
                          },
                          fallback: '127.0.0.1'
                        ),
                      ),
                    );
                    setState(() {
                      response = res;
                    });
                  } catch (e, st) {
                    print(e);
                    print(st);
                  }
                },
                child: const Text('Test'),
              ),
              if (response != null) ResponseCard(response: response!),
            ],
          ),
        ),
      ),
    );
  }
}