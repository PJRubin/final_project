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
      home: MyHomePage(title: 'Star Wars App'),
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


  Future<acharacter.Character> _getCharacter() async {

    _person = searchTextField.text;
    String ur = _lookForPerson(_person);

    Uri url = Uri.parse(ur);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {

      setState(() {
       _character = acharacter.characterFromJson(response.body);
       acharacter.Properties _characterProps = _character.result.properties;
       _height = _characterProps.height;
       _name = _characterProps.name;
       _skincolor = _characterProps.skinColor;
       _haircolor = _characterProps.hairColor;
       _eyecolor = _characterProps.eyeColor;
       _homeworld = _characterProps.homeworld;
      });
      _getPlanet();
      return _character;
    } else {
      print("HTTP Error with code ${response.statusCode}");
      return _character;
    }
  }


  //get the planet

  aplanet.Planet _planet;
 String _charhomeworld = "Tatooine";


  Future<aplanet.Planet> _getPlanet() async {
    Uri url = Uri.parse(_homeworld);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      _planet = aplanet.planetFromJson(response.body);

      aplanet.Properties _planetProps = _planet.result.properties;
      setState(() {

      _charhomeworld = _planetProps.name;
      });

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


      });
    });

    _getPlanet().then((newPlanet) {
      setState(() {
        _planet = newPlanet;

      });
    });
  }

  String _height = "";
  String _name = "";
  String _skincolor = "";
  String _haircolor = "";
  String _eyecolor = "";
  String _homeworld = "";


  final searchTextField = TextEditingController();
  String _person;



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
              _name,
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
              'Height: ' + _height,
            ),
            Text(
              'Skin Color: ' + _skincolor,
            ),
            Text(
              'Eye Color: ' + _eyecolor,
            ),
            Text(
              'Hair Color: ' + _haircolor,
            ),
            Text(
              'Birth Planet: ' + _charhomeworld,
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

  String _lookForPerson(String person) {
    String test = person.toUpperCase();
    if(test == ("LUKE SKYWALKER"))
     {
        return "https://www.swapi.tech/api/people/1";
      }
    else if(test.toString() == ("c-3po"))
      {
        return "https://www.swapi.tech/api/people/2";
      }
    else if(test.toString() == ("r2-d2"))
    {
      return "https://www.swapi.tech/api/people/3";
    }
    else if(test.toString() == ("DARTH VADER"))
    {
      return "https://www.swapi.tech/api/people/4";
    }
    else if(test.toString() == "LEIA ORGANA")
    {
      return "https://www.swapi.tech/api/people/5";
    }
    else if(test.toString() == "OBI-WAN KENOBI")
    {
      return "https://www.swapi.tech/api/people/10";
    }
    else if(test.toString() == "ANAKIN SKYWALKER")
    {
      return "https://www.swapi.tech/api/people/11";
    }
    else if("".contains(test))
    {
      return "https://www.swapi.tech/api/people/1";
    }
    else if("".contains(test))
    {
      return "https://www.swapi.tech/api/people/1";
    }
    else
      {
        return "https://www.swapi.tech/api/people/1";
      }
  }
}
