import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Character.dart' as acharacter;
import 'Planet.dart' as aplanet;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  //int _counter = 0;





//get the character
  acharacter.Character _character;
  acharacter.Properties _characterProps;

  Future<acharacter.Character> _getCharacter() async {
    Uri url = Uri.parse('https://www.swapi.tech/api/people/1');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
       _character = acharacter.characterFromJson(response.body);
      return _character;
    } else {
      print("HTTP Error with code ${response.statusCode}");
      return _character;
    }
  }


  //get the planet

  aplanet.Planet _planet;
  aplanet.Properties _planetProps;

  Future<aplanet.Planet> _getPlanet() async {
    Uri url = Uri.parse(_characterProps.homeworld);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      _planet = aplanet.planetFromJson(response.body);
      return _planet;
    } else {
      print("HTTP Error with code ${response.statusCode}");
      return _planet;
    }
  }

  @override
  initState()  {
    super.initState();
    _getCharacter().then((newCharacter) {
      setState(() {
        _character = newCharacter;
        _characterProps = _character.result.properties;
      });
    });

    _getPlanet().then((newPlanet) {
      setState(() {
        _planet = newPlanet;
        _planetProps = _planet.result.properties;
      });
    });
  }


  final searchTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _characterProps.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            FittedBox(
            child:Image(
              width:200,
                height:300,
                image: NetworkImage('https://media.contentapi.ea.com/content/dam/star-wars-battlefront-2/images/2019/08/swbf2-refresh-hero-large-heroes-page-luke-skywalker-16x9-xl.jpg.adapt.crop1x1.320w.jpg')

            ),

            ),


            Text(
              'Height: ' + _characterProps.height,
            ),
            Text(
              'Skin Color: ' + _characterProps.skinColor,
            ),
            Text(
              'Eye Color: ' + _characterProps.eyeColor,
            ),
            Text(
              'Hair Color: ' + _characterProps.hairColor,
            ),
            Text(
              'Birth Planet: ' + _characterProps.name,
            ),


            Expanded(child: Container()),

            TextField(
              decoration: InputDecoration(
                hintText: "Enter a character's name"
              ),
              controller: searchTextField,
            ),
          ],
        ),


      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _getCharacter,
        tooltip: 'Search',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
