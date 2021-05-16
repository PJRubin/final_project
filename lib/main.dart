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

  String _netImage = "https://media.contentapi.ea.com/content/dam/star-wars-battlefront-2/images/2019/08/swbf2-refresh-hero-large-heroes-page-luke-skywalker-16x9-xl.jpg.adapt.crop1x1.320w.jpg";

   _setImage()
  {
    setState(() {
        return _netImage;
    });


  }



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
                image: NetworkImage(_netImage)

            ),

            ),


            Text(
              'Height: ' + _height + " cm",
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

            RaisedButton(
              child: Text('See Options'),
              onPressed: () {
                showAlertDialog(context);
              },
            ),

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
    if("LUKE SKYWALKER".contains(test))
     {
       _netImage = "https://media.contentapi.ea.com/content/dam/star-wars-battlefront-2/images/2019/08/swbf2-refresh-hero-large-heroes-page-luke-skywalker-16x9-xl.jpg.adapt.crop1x1.320w.jpg";
       _setImage();
       return "https://www.swapi.tech/api/people/1";
      }
    else if("C-3PO".contains(test))
      {
        _netImage = "https://i.ebayimg.com/images/g/lfoAAOSwNMZeRXEB/s-l640.jpg";
        _setImage();
        return "https://www.swapi.tech/api/people/2";
      }
    else if("R2-D2".contains(test))
    {
      _netImage = "https://images-na.ssl-images-amazon.com/images/I/61srwGulapL._AC_SX522_.jpg";
      _setImage();
      return "https://www.swapi.tech/api/people/3";
    }
    else if("DARTH VADER".contains(test))
    {
      _netImage = "https://s7.orientaltrading.com/is/image/OrientalTrading/VIEWER_ZOOM/darth-vader-cardboard-stand-up~13577316";
       _setImage();
      return "https://www.swapi.tech/api/people/4";
    }
    else if("LEIA ORGANA".contains(test))
    {
      _netImage = "https://static.wikia.nocookie.net/fictupedia/images/1/1d/Leia-princess-leia-organa-solo-skywalker-9301321-576-1010.jpg/revision/latest/scale-to-width-down/576?cb=20170120065805";
      _setImage();
      return "https://www.swapi.tech/api/people/5";
    }
    else if("OBI-WAN KENOBI".contains(test))
    {
      _netImage = "https://static2.cbrimages.com/wordpress/wp-content/uploads/2018/06/ewan-mcgregor-obi-wan-kenobi-header.jpg";
      _setImage();
      return "https://www.swapi.tech/api/people/10";
    }
    else if("ANAKIN SKYWALKER".contains(test))
    {
      _netImage = "https://static.wikia.nocookie.net/starwars/images/6/6f/Anakin_Skywalker_RotS.png/revision/latest?cb=20130621175844";
      _setImage();
      return "https://www.swapi.tech/api/people/11";
    }
    else if("CHEWBACCA".contains(test))
    {
      _netImage = "https://starwarsblog.starwars.com/wp-content/uploads/2018/06/chewbacca-solo-tall.jpg";
      _setImage();
      return "https://www.swapi.tech/api/people/13";
    }
    else if("HAN SOLO".contains(test))
    {
      _netImage = "https://lumiere-a.akamaihd.net/v1/images/han-solo-main_a4c8ff79.jpeg?region=0%2C0%2C1920%2C960";
      _setImage();
      return "https://www.swapi.tech/api/people/1";
    }
    else if("YODA".contains(test))
      {
        _netImage = "https://static.wikia.nocookie.net/starwars/images/d/d6/Yoda_SWSB.png/revision/latest?cb=20150206140125";
        _setImage();
        return "https://www.swapi.tech/api/people/20";
      }
    else
      {
        _netImage = "https://media.contentapi.ea.com/content/dam/star-wars-battlefront-2/images/2019/08/swbf2-refresh-hero-large-heroes-page-luke-skywalker-16x9-xl.jpg.adapt.crop1x1.320w.jpg";
        _setImage();
        return "https://www.swapi.tech/api/people/1";
      }
  }

  //code from https://www.javatpoint.com/flutter-alert-dialogs

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Characters"),
      content: Text(" Luke Skywalker \n c-3po \n r2-d2 \n Darth Vader \n Leia organa \n Obi-wan Kenobi \n Anakin Skywalker \n Chewbacca \n Han Solo \n Yoda"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


