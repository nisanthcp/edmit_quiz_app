import 'package:auto_size_text/auto_size_text.dart';
import 'package:edmit_quiz_app/screen/state/state_manager.dart';
import 'package:flutter/material.dart';

import 'database/category_provider.dart';
import 'database/db_helper.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {},
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'EDMIT Quiz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Category>>(
          future: getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text('${snapshot.error}'),
              );
            else if (snapshot.hasData) {
              Category category = new Category();
              category.id = -1;
              category.name = 'Exam';
              snapshot.data.add(category);
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: snapshot.data.map((category) {
                  return GestureDetector(
                    
                    child: Card(
                      elevation: 2,
                      color: category.id == -1 ? Colors.green : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: AutoSizeText(
                              '${category.name}',
                              style: TextStyle(
                                  color: category.id == -1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  
                  onTap: () => print('Click to ${category.name}'),);               
                }).toList(),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }

  Future<List<Category>> getCategories() async {
    var db = await copyDB();
    var result = await CategoryProvider().getCateogories(db);
    context.read(categoryListProvider).state = result;
    return result;
  }
}
