import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cat_facts_model.dart';
// tutorial https://www.coderzheaven.com/2020/03/25/easily-parse-json-create-json-model-classes-show-in-listview/
// Data from    'api_key=947be2b6-57e5-452a-92aa-5152d50e823a'
// json to dart  https://app.quicktype.io/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JsonListWidget(),
    );
  }
}

class JsonListWidget extends StatefulWidget {
  JsonListWidget() : super();
  @override
  _JsonListWidgetState createState() => _JsonListWidgetState();
}

class _JsonListWidgetState extends State<JsonListWidget> {
  //
  List<CatFact> _catFacts;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    print("in initState and calling Services.getUsers");
    getCatFacts().then((newCatFacts) {
      setState(() {
        print("in initState and cat facts = ${newCatFacts.length}");
        _catFacts = newCatFacts;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Cat Facts'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _catFacts ? 0 : _catFacts.length,
          itemBuilder: (context, index) {
            CatFact user = _catFacts[index];
            return ListTile(
              title: Text(user.text),
              subtitle: Text(user.type),
              leading: Image.network('https://chappellevet.ca/wp-content/uploads/2021/03/Abyssinian-540x553.jpg'),
            );
          },
        ),
      ),
    );
  }

  static Future<List<CatFact>> getCatFacts() async {
    //String str_url = 'https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=25';
    Uri url = Uri.parse('https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=25');
    try {
      final response = await http.get(url);
      print ("response recieved with status code = ${response.statusCode}");
      if (response.statusCode == 200) {
        final List<CatFact> users = catFactFromJson(response.body);
        return users;
      } else {
        print("Json_Services incorrect HTTP response code of ${response.statusCode}");
        return List<CatFact>.empty();
      }
    } catch (e) {
      print("Json_Services exception ${e.toString()}");
      return List<CatFact>.empty();
    }
  }

}

class Json_Services {
  static Future<List<CatFact>> getUsers() async {
    //String str_url = 'https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=25';
    Uri url = Uri.parse('https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=25');
    try {
      final response = await http.get(url);
      print ("response recieved with status code = ${response.statusCode}");
      if (response.statusCode == 200) {
        final List<CatFact> users = catFactFromJson(response.body);
        return users;
      } else {
        print("Json_Services incorrect HTTP response code of ${response.statusCode}");
        return List<CatFact>.empty();
      }
    } catch (e) {
      print("Json_Services exception ${e.toString()}");
      return List<CatFact>.empty();
    }
  }
}