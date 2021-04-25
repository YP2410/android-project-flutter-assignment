import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}


class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //FirebaseAuth auth = FirebaseAuth.instance;
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
                  child: Text(snapshot.error.toString(), textDirection: TextDirection.ltr)));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return ChangeNotifierProvider(
        create: (_) => AuthRepository.instance(),
        child: MaterialApp(
          title: 'Startup Name Generator',
          theme: ThemeData(   // Add the 3 lines from here...
            primaryColor: Colors.red,
          ),
          home: RandomWords(),
        ));
  }
}


class LoginView extends StatelessWidget {
  final updateUponLogin;
  LoginView(this.updateUponLogin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginScreen(updateUponLogin));
  }
}

class SquareMaterial extends StatelessWidget {
  final double? width;
  final double height;
  final Color? color;

  const SquareMaterial({
    Key? key,
    this.height = 100.0,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 0,
        color: this.color ?? Colors.grey[300],
        child: SizedBox(
          width: this.width,
          height: this.height,
        ),
      ),
    );
  }
}

class TextMaterial extends StatelessWidget {
  final double width;
  final Alignment alignment;

  const TextMaterial(
      {Key? key, required this.width, this.alignment = Alignment.topLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(5),
          ),
          height: 13.0,
          width: width,
        ),
      ),
    );
  }
}


/*class DummyBackgroundContent extends StatelessWidget {
  final accent = Color(0xff8ba38d);
  final _names = <WordPair>[];                 // NEW
  Set<WordPair> _liked = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(builder: (context, userData, _) {
      return Scaffold(
        body: _buildSuggestions(),
      );
    });
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _names.length) {
            _names.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_names[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final likedAlready = _liked.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        likedAlready ? Icons.favorite : Icons.favorite_border,
        color: likedAlready ? Colors.red : null,
      ),
      onTap: () async {
        setState(() {
          if (likedAlready) {
            _liked.remove(pair);
          } else {
            _liked.add(pair);
          }
        });
        final data = Provider.of<AuthRepository>(context, listen: false);
        //check if user is logged in
        if (data.status == Status.Authenticated) {
          if (likedAlready) {
            await LikedNames.instance().remove(data.user!, pair);
          } else {
            await LikedNames.instance().newLikedName(data.user!, pair);
          }
        }
      },
    );
  }

}*/


class DefaultGrabbing extends StatefulWidget {


  @override
  _DefaultGrabbingState createState() => _DefaultGrabbingState();
}

class _DefaultGrabbingState extends State<DefaultGrabbing> {

  double sideLength = 300;
  double heightLength = 300;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,

      child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Welcome back, ${AuthRepository.instance()._authintication.currentUser!.email!} ', style: TextStyle(fontSize: 17),),
              Icon(Icons.keyboard_arrow_up),
            ],
          ),
          onTap: () {
          setState(() {
            //print(2);
            /*setState(() {
              sideLength == 50 ? sideLength = 100 : sideLength = 50;
              _RandomWordsState()._scrollController.position.maxScrollExtent;
            });*/
            if(_RandomWordsState().controller.currentPosition > 135.854854 ||  _RandomWordsState().controller.currentPosition <= 37.5){
              _RandomWordsState().controller.snapToPosition(
                  SnappingPosition.factor(
                    positionFactor:0.2,
                    snappingCurve: Curves.elasticOut,
                    snappingDuration: Duration(milliseconds: 450)
              ));
            }
            else{
              _RandomWordsState().controller.snapToPosition(
              SnappingPosition.pixels(positionPixels: 37.5, snappingCurve: Curves.elasticOut,
                  snappingDuration: Duration(milliseconds: 450)));
            }
    });
          },
        ),

    );
  }


  /*double sideLength = 50;

  BorderRadius _getBorderRadius() {
    var radius = Radius.circular(25.0);
    return BorderRadius.only(
      topLeft: widget.reverse ? Radius.zero : radius,
      topRight: widget.reverse ? Radius.zero : radius,
      bottomLeft: widget.reverse ? radius : Radius.zero,
      bottomRight: widget.reverse ? radius : Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
         setState(() {
          sideLength == 50 ? sideLength = 100 : sideLength = 50;
      });
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: 10,
              color: Colors.black.withOpacity(0.15),
            )
          ],
          borderRadius: _getBorderRadius(),
          color: this.widget.color,
        ),
        child: Transform.rotate(
          angle: widget.reverse ? pi : 0,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.5),
                child: _GrabbingIndicator(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 2.0,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }*/
}

class _GrabbingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey[400],
      ),
      height: 5,
      width: 75,
    );
  }
}


class DummyContent extends StatefulWidget {
  final bool reverse ;
  final ScrollController? controller;


   DummyContent({Key? key, this.controller, this.reverse = false})
     : super(key: key);

  @override
  _DummyContentState createState() => _DummyContentState();
}

class _DummyContentState extends State<DummyContent> {
  final picker = ImagePicker();
  String imageLink = "";
  set setimageLing(String value){
    imageLink = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        reverse: this.widget.reverse,
        padding: EdgeInsets.all(20).copyWith(top: 30),
        controller: widget.controller,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [

              //child: Text("Picture"),
              //backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
              Container(
                width: 70,
                height: 70,
                child: Image(
                  image: NetworkImage(imageLink != ""
                      ? imageLink
                      : 'https://uxwing.com/wp-content/themes/uxwing/download/07-design-and-development/image-not-found.png'),
                ),
              ),

            Column(
              children: [
                Text('${AuthRepository.instance()._authintication.currentUser!.email!} ', style: TextStyle(fontSize: 17),),
                RaisedButton(
                  child: Text("Change avatar"),
                  color: Colors.green,
                  onPressed: () async {
                    File _image;
                    final picker = ImagePicker();
                    var pickedFile = await picker.getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      _image = File(pickedFile.path);
                      //print(_RandomWordsState().userID);
                      //print(AuthRepository.instance()._authintication.currentUser!.uid);
                      //print(2222222);

                      await FirebaseStorage.instance.ref().child(AuthRepository.instance()._authintication.currentUser!.uid).putFile(_image);
                      imageLink= await FirebaseStorage.instance.ref().child(AuthRepository.instance()._authintication.currentUser!.uid).getDownloadURL();
                      setState(() {
                      });
                    } else {
                      final snackBar = SnackBar(
                          content:
                          Text("No image selected"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                )
              ],
            ),
            //const SizedBox(height: 10.0),

          ],
        )
        /*child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextMaterial(width: 150, alignment: Alignment.center),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareMaterial(
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 15),
                SquareMaterial(
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 15),
                SquareMaterial(
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            SizedBox(height: 25),
            TextMaterial(width: double.infinity),
            TextMaterial(width: 160),
            Row(
              children: [
                Expanded(child: SquareMaterial(height: 200)),
                Expanded(child: SquareMaterial(height: 200)),
              ],
            ),
            Row(
              children: [
                Expanded(child: SquareMaterial(height: 200)),
                Expanded(child: SquareMaterial(height: 200)),
                Expanded(child: SquareMaterial(height: 200)),
              ],
            ),
            SizedBox(height: 25),
            TextMaterial(width: double.infinity),
            TextMaterial(width: double.infinity),
            TextMaterial(width: 230),
            SquareMaterial(height: 300),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: SquareMaterial(height: 100)),
                Expanded(child: SquareMaterial(height: 100)),
                Expanded(child: SquareMaterial(height: 100)),
                Expanded(child: SquareMaterial(height: 100)),
                Expanded(child: SquareMaterial(height: 100)),
              ],
            ),
            TextMaterial(width: double.infinity),
            TextMaterial(width: 230),
          ],
        ),*/
      ),
    );
  }
}


class RandomWords extends StatefulWidget {

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _names = <WordPair>[];                 // NEW
  Set<WordPair> _liked = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18); // NEW
  //final snappingSheetController = SnappingSheetController();
  final ScrollController _scrollController = ScrollController();
  final controller = SnappingSheetController();




  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(builder: (context, userData, _) {
      return Scaffold(

          appBar: AppBar(title: Text('Startup Name Generator'), actions: [
            IconButton(icon: Icon(Icons.favorite), onPressed: _pushSaved),
            (userData.status == Status.Authenticated) ? IconButton(   //if user is logged in show exit_to_app icon, else show login icon
                icon: Icon(Icons.exit_to_app), onPressed: () async {
                  final participant = Provider.of<AuthRepository>(context, listen: false);
                  clearLiked();
                  await participant.logOut();
                })
                : IconButton(icon: Icon(Icons.login),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (context) => LoginView(likedLogin))))
          ]),
        body: (userData.status == Status.Authenticated) ?
          //final snappingSheetController = SnappingSheetController();

      SnappingSheet(

        controller: controller,

          lockOverflowDrag: true,
          snappingPositions: [
            SnappingPosition.factor(
              positionFactor: 0.0,
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
            SnappingPosition.factor(
              snappingCurve: Curves.elasticOut,
              snappingDuration: Duration(milliseconds: 1750),
              positionFactor: 0.5,
            ),
            SnappingPosition.factor(positionFactor: 0.9),
          ],
          child: _buildSuggestions(),
          grabbingHeight: 75,
          grabbing:  Material(
        color: Colors.grey,

        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Welcome back, ${AuthRepository.instance()._authintication.currentUser!.email!} ', style: TextStyle(fontSize: 17),),
              Icon(Icons.keyboard_arrow_up),
            ],
          ),
          onTap: () {
            setState(() {
              //print(2);
              /*setState(() {
              sideLength == 50 ? sideLength = 100 : sideLength = 50;
              _RandomWordsState()._scrollController.position.maxScrollExtent;
            });*/
              if(controller.currentPosition > 135.854854 ||  controller.currentPosition <= 37.5){
                controller.snapToPosition(
                    SnappingPosition.factor(
                        positionFactor:0.2,
                        snappingCurve: Curves.elasticOut,
                        snappingDuration: Duration(milliseconds: 450)
                    ));
              }
              else{
               controller.snapToPosition(
                    SnappingPosition.pixels(positionPixels: 37.5, snappingCurve: Curves.elasticOut,
                        snappingDuration: Duration(milliseconds: 450)));
              }
            });
          },
        ),

      ),
          sheetBelow: SnappingSheetContent(
            childScrollController: _scrollController,
            draggable: true,
            child: DummyContent(
              controller: _scrollController,

            ),
          ),
        )
            : _buildSuggestions()
          //_buildSuggestions(), !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      );
    });
  }
  void _pushSaved() {
    final snackBar = SnackBar(content: Text('Deletion is not implemented yet'));
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
      builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestions'),
              ),
              body: StatefulBuilder(builder: (context, update) {
                var userData = Provider.of<AuthRepository>(context);

                if (userData.status != Status.Authenticated) {
                  final tiles = _liked.map((WordPair pair) {
                      return ListTile(title: Text(pair.asPascalCase, style: _biggerFont,),
                        trailing: IconButton(icon: Icon(Icons.delete),
                            onPressed: () { update(() {
                                _liked.remove(pair);
                                setState(() {});
                              });
                            }),
                      );
                    },
                  ).toList();
                  final divided = ListTile.divideTiles(
                    context: context,
                    tiles: tiles,
                  ).toList();
                  return ListView(children: divided);
                } else {
                  return StreamBuilder<List<WordPair>>(
                      stream: LikedNames.instance().getLikedNames(userData.user!),
                      builder: (context, snapshot) { Set<WordPair> All;
                        if (snapshot.hasData) {
                          All = (snapshot.data! + _liked.toList()).toSet();
                          _liked = All;
                        } else {
                          All = _liked;
                        }
                        final tiles = All.map((WordPair pair) {
                            return ListTile(
                              title: Text(
                                pair.asPascalCase,

                                style: _biggerFont,
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async { setState(() {
                                      _liked.remove(pair);
                                    });
                                    await LikedNames.instance()
                                        .remove(userData.user!, pair);
                                  }),
                            );
                          },
                        ).toList();
                        final divided = ListTile.divideTiles(
                          context: context,
                          tiles: tiles,
                        ).toList();
                        return ListView(children: divided);
                      });
                }
              }));
        },
      ),
    );
  }
  void _pushLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginView(likedLogin())));
  }

  Future likedLogin() async {
    final data = Provider.of<AuthRepository>(context, listen: false);
    final newLiked =  await LikedNames.instance().newLikedNames(data.user!, _liked);
    setState(() {
      _liked = newLiked.toSet();
    });
    return Future.delayed(Duration.zero);
  }
  void clearLiked() {
    _liked.clear();
  }


  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _names.length) {
            _names.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_names[index]);
        }
    );
  }

  String userID = "";
  Widget _buildRow(WordPair pair) {
    final likedAlready = _liked.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        likedAlready ? Icons.favorite : Icons.favorite_border,
        color: likedAlready ? Colors.red : null,
      ),
      onTap: () async {
        setState(() {
          if (likedAlready) {
            _liked.remove(pair);
          } else {
            _liked.add(pair);
          }
        });
        final data = Provider.of<AuthRepository>(context, listen: false);
        //check if user is logged in
        if (data.status == Status.Authenticated) {
          if (likedAlready) {
            await LikedNames.instance().remove(data.user!, pair);
          } else {
            await LikedNames.instance().newLikedName(data.user!, pair);
          }
        }
      },
    );
  }

}
class LoginScreen extends StatefulWidget{
  final updateUponLogin;
  LoginScreen(this.updateUponLogin);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  final snackBar = SnackBar(content: Text('There was an error logging into the app'));
  final snackBar2 = SnackBar(content: Text('There was an error registering to the app'));
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmation = new TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(builder: (context, participant, _) {
      return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20.5),
            child: Column(children: [
              Center(
                  child: Text("Welcome to Startup Names Generator, please log in below", textScaleFactor: 1.5)),
              Padding(
                  padding: EdgeInsets.all(15)),
              Form(
                child: Column(children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                      hintText: 'Enter Your Name',),),
                Padding(
                    padding: EdgeInsets.all(15)),
                  TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',),),
                  (participant.status == Status.Authenticating)
                      ? Center(child: LinearProgressIndicator())
                      : RaisedButton(
                    onPressed: () async {
                      final participant = Provider.of<AuthRepository>(context,
                          listen: false);
                      if (!await participant.signIn(emailController.text, passwordController.text, widget.updateUponLogin)) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Login'),
                    color: Colors.red,
                    shape: ContinuousRectangleBorder(
                        side: BorderSide(color: Colors.red)),
                    textColor: Colors.white,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      /*final participant = Provider.of<AuthRepository>(context,
                          listen: false);
                      if (!await participant.signIn(emailController.text, passwordController.text, widget.updateUponLogin)) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.of(context).pop();
                      }*/
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  //leading: new Icon(Icons.photo),
                                  title: new Text('Please confirm your password below:'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextField(
                                  controller: passwordConfirmation,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    errorText: _validate ? 'Passwords must match' : null,
                                    hintText: 'Enter Password',),),
                                RaisedButton(
                                  onPressed: () async {
                                    if(passwordController.text != passwordConfirmation.text){
                                        _validate = true;
                                    }
                                    else {
                                      _validate = false;
                                      final participant = Provider.of<AuthRepository>(context,
                                          listen: false);
                                      await participant.signUp(emailController.text, passwordController.text, widget.updateUponLogin);
                                        //ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                                      Navigator.pop(context);
                                      Navigator.of(context).pop();

                                    }
                                  },

                                    child: Text('Confirm'),
                                    color: Colors.green,
                                    shape: ContinuousRectangleBorder(
                                    side: BorderSide(color: Colors.green)),
                                    textColor: Colors.white,
                                    ),
                              ],
                            );
                          });
                    },
                    child: Text('New user? Click to sign up'),
                    color: Colors.green,
                    shape: ContinuousRectangleBorder(
                        side: BorderSide(color: Colors.green)),
                    textColor: Colors.white,
                  )

                ]),
              ),
            ])),
      );
    });
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
class AuthRepository with ChangeNotifier {
  FirebaseAuth _authintication;
  User? _participant;
  Status _userStatus = Status.Uninitialized;
  AuthRepository.instance() : _authintication = FirebaseAuth.instance {
    _authintication.authStateChanges().listen(_loginUpdated);
  }
  Status get status => _userStatus;

  User? get user => _participant;
  Future<bool> signIn(String email, String password, updateUponLogin) async {
    try {
      _userStatus = Status.Authenticating;
      notifyListeners();
      await _authintication.signInWithEmailAndPassword(email: email, password: password);
      //_RandomWordsState().userID = _authintication.currentUser!.uid;
      //print(_RandomWordsState().userID);
      /*try {
        _RandomWordsState().imageLink = await FirebaseStorage.instance.ref()
            .child(AuthRepository.instance()._authintication.currentUser!.uid)
            .getDownloadURL();
      }
      catch(e){
      }*/
      await LikedNames.instance().freshClient(user!);
      await updateUponLogin();
      return true;
    } catch (e) {
      _userStatus = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }
  Future<UserCredential?> signUp(String email, String password, updateUponLogin) async {
    try {
      _userStatus = Status.Authenticating;
      notifyListeners();
      return await _authintication.createUserWithEmailAndPassword(
          email: email, password: password);

      await LikedNames.instance().freshClient(user!);
      await updateUponLogin();
      //return true;
    } catch (e) {
      print(e);
      _userStatus = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }
  Future<void> _loginUpdated(User? user) async {
    if (user == null) {
      _userStatus = Status.Unauthenticated;
    } else {
      _participant = user;
      _userStatus = Status.Authenticated;
    }
    notifyListeners();
  }

  Future logOut() async {
    await _authintication.signOut();
    _userStatus = Status.Unauthenticated;
    notifyListeners();
    _participant = null;
    return Future.delayed(Duration.zero);
  }
}
class LikedNames {
  FirebaseFirestore _database;

  String _LikedNamesPath = 'likedNames';
  LikedNames.instance() : _database = FirebaseFirestore.instance;


  Future freshClient(User user) async {
    return _database.collection(_LikedNamesPath).doc(user.uid).get().then((docSnapshot) {
      if (!docSnapshot.exists) {
        _database.collection(_LikedNamesPath).doc(user.uid).set({'saved': []});
      }
    });
  }
  Stream<List<WordPair>> getLikedNames(User user) {
    return _database.collection(_LikedNamesPath).doc(user.uid).snapshots().map((doc) => _switch(doc['saved']));
  }
  Future remove(User user, WordPair pair) async {
    var arr = await _database.collection(_LikedNamesPath).doc(user.uid).get().then((doc) => doc['saved']);
    List<WordPair> likedNames = _switch(arr);
    if (likedNames.contains(pair)) {
      likedNames.remove(pair);
      await _database.collection(_LikedNamesPath).doc(user.uid).set({'saved': _switchBackwards(likedNames)});
    }
    return Future.delayed(Duration.zero);
  }




  Future newLikedName(User user, WordPair pair) async {
    var arr = await _database.collection(_LikedNamesPath).doc(user.uid).get().then((doc) => doc['saved']);
    List<WordPair> likedNames = _switch(arr);
    if (!likedNames.contains(pair)) {
      likedNames.add(pair);
      await _database.collection(_LikedNamesPath).doc(user.uid).set({'saved': _switchBackwards(likedNames)});
    }
    return Future.delayed(Duration.zero);
  }
  Future<List<WordPair>> newLikedNames(User user, Set<WordPair> words) async {
    var arr = await _database.collection(_LikedNamesPath).doc(user.uid).get().then((doc) => doc['saved']);
    List<WordPair> likedNames = _switch(arr);
    likedNames.addAll(words);
    final previous = Set<WordPair>();
    final special = likedNames.where((pair) => previous.add(pair)).toList();
    await _database.collection(_LikedNamesPath).doc(user.uid).set({'saved': _switchBackwards(special)
    });
    return special;
  }
  List<String> _switchBackwards(List<WordPair> words) {
    return words.map((pair) => ('${pair.first},${pair.second}')).toList();
  }
  List<WordPair> _switch(List<dynamic> arr) {
    return arr.map((item) {
      final word = (item as String).split(',');
      return WordPair(word[0], word[1]);
    }).toList();
  }
}





