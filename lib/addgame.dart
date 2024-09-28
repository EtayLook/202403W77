import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import "homepage.dart";
import 'table.dart';
import 'stats.dart';
import 'scroll.dart';
import 'addteam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

String user_name = "";
String searchValue = '';
DateTime now = DateTime.now();

double search_lat = 32.903021;
double search_lng = 35.287875;

TextEditingController home_team = TextEditingController();
TextEditingController away_team = TextEditingController();
TextEditingController score = TextEditingController();
TextEditingController game_date = TextEditingController();

final List<String> _suggestions = [
  'Afeganistan',
  'Albania',
  'Algeria',
  'Australia',
  'Brazil',
  'German',
  'Madagascar',
  'Mozambique',
  'Portugal',
  'Zambia'
];
List<String> genderOptions = [
  'Airforce',
  'Military',
  'Navy',
];
String type = "Airforce";

class addgame extends StatefulWidget {
  const addgame({super.key});

  @override
  State<addgame> createState() => _addgame();
}

class _addgame extends State<addgame> with SingleTickerProviderStateMixin {
  final _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //firestart();
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 142, 94, 254),
          body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "בית",
                                    style: GoogleFonts.alata(
                                        fontSize: 12,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => const homepage()));
                                  },
                                ),
                                GestureDetector(
                                  child: Text(
                                    "טבלה",
                                    style: GoogleFonts.alata(
                                        fontSize: 12,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => const table()));
                                  },
                                ),
                                GestureDetector(
                                  child: Text(
                                    "הוספת משחק",
                                    style: GoogleFonts.alata(
                                        fontSize: 16,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => const addgame()));
                                  },
                                ),
                                GestureDetector(
                                  child: Text(
                                    "רישום קבוצה",
                                    style: GoogleFonts.alata(
                                        fontSize: 12,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => const addteam()));
                                  },
                                ),
                                GestureDetector(
                                  child: Text(
                                    "סטטיסטיקות",
                                    style: GoogleFonts.alata(
                                        fontSize: 12,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => const stats()));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "עדכון משחק ",
                                  style: GoogleFonts.alata(
                                      fontSize: 25,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                    'assets/notebook.gif',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      //color: const Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "מנצחת",
                              style: GoogleFonts.alata(
                                  fontSize: 25,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: home_team,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "לדוגמה: מכבי חיפה",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "מפסידה",
                              style: GoogleFonts.alata(
                                  fontSize: 25,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: away_team,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "לדוגמה: מכבי נתניה",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "תוצאה",
                              style: GoogleFonts.alata(
                                  fontSize: 25,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: score,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "2-1 :לדוגמה",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "תאריך",
                              style: GoogleFonts.alata(
                                  fontSize: 25,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: game_date,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "לדוגמה:  22.08.2024",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("games")
                                      .doc()
                                      .set(
                                    {
                                      'win_team': home_team.text,
                                      'lose_team': away_team.text,
                                      'score': score.text,
                                      'date': game_date,
                                      'real': now,
                                    },
                                  );
                                  String allScore = score.text;
                                  final dateList = allScore.split("-");
                                  if (dateList[0] == dateList[1]) {
                                    FirebaseFirestore.instance
                                        .collection("teams")
                                        .doc(home_team.text)
                                        .update(
                                      {
                                        'team_score': FieldValue.increment(1),
                                        'team_draws': FieldValue.increment(1),
                                      },
                                    );
                                    FirebaseFirestore.instance
                                        .collection("teams")
                                        .doc(away_team.text)
                                        .update(
                                      {
                                        'team_score': FieldValue.increment(1),
                                        'team_draws': FieldValue.increment(1),
                                      },
                                    );
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection("teams")
                                        .doc(home_team.text)
                                        .update(
                                      {
                                        'team_score': FieldValue.increment(3),
                                        'team_wins': FieldValue.increment(1),
                                      },
                                    );
                                    FirebaseFirestore.instance
                                        .collection("teams")
                                        .doc(away_team.text)
                                        .update(
                                      {
                                        'team_score': FieldValue.increment(3),
                                        'team_losses': FieldValue.increment(1),
                                      },
                                    );
                                  }
                                  ok_dialog(context);
                                },
                                child: const Text('עדכן שינויים'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }

  Future<void> firestart() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:
            "AIzaSyAGm4tBklkJtvx-OyAB4NmmlXcrp6PC_jo", // paste your api key here
        appId:
            "1:530041174764:android:7aac2b6afb68759ede43c9", //paste your app id here
        messagingSenderId: "530041174764", //paste your messagingSenderId here
        projectId: "soccer-567af", //paste your project id here
      ),
    );
  }

  Row headerBottomBarWidget() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
    );
  }

  Container bottombar() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 2),
              //set border radius to 50% of square height and width
              image: DecorationImage(
                image: Image.asset("assets/logo1.jpeg").image,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 2),
              //set border radius to 50% of square height and width
              image: DecorationImage(
                image: Image.asset("assets/logo2.jpeg").image,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 2),
              //set border radius to 50% of square height and width
              image: DecorationImage(
                image: Image.asset("assets/logo3.jpeg").image,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 2),
              //set border radius to 50% of square height and width
              image: DecorationImage(
                image: Image.asset("assets/logo4.jpeg").image,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 2),
              //set border radius to 50% of square height and width
              image: DecorationImage(
                image: Image.asset("assets/logo5.jpeg").image,
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Application completed"),
      content: const SizedBox(
        height: 100,
        child: Column(
          children: [
            Text(
                "Thank you for registering for the 2024 Project UpStart Hackathon. "),
            SizedBox(
              height: 10,
            ),
            Text("A confirmation and invitation has been sent to your email. "),
          ],
        ),
      ),
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

  ok_dialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "אישור",
        style: GoogleFonts.alata(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.normal),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const homepage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "הפעולה בוצעה",
        style: GoogleFonts.alata(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.normal),
      ),
      content: Text(
        "הינך חוזר לעמוד הבית",
        style: GoogleFonts.alata(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.normal),
      ),
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