import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:land_wiki/modules/wiki/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppApi {
  static Future getWiki({
    required String text,
  }) async {
    String apiUrl = 'https://codingwiki.onrender.com/get/{$text}';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return Wiki.fromJson(jsonData);
      } else {
        throw 'Erreur lors de la requête : ${response.statusCode}';
      }
    } catch (exception) {
      throw 'Erreur lors de la requête : $exception';
    }
  }

  static Future saveWikiList(List<Wiki> wikiList) async {
    final db = await SharedPreferences.getInstance();
    return await db.setString('wikiList', json.encode(wikiList));
  }

  static Future<List<Wiki>> getWikiList() async {
    final db = await SharedPreferences.getInstance();
    List<Wiki> wikiList = [];
    if (db.containsKey('wikiList')) {
      var jsonData = json.decode(db.getString('wikiList')!);
      for (var wiki in jsonData) {
        wikiList.add(Wiki.fromJson(wiki));
      }
    } else {
      await db.setString("wikiList", json.encode([]));
    }
    return wikiList;
  }

  static Future appendWiki(Wiki wiki) async {
    final List<Wiki> wikiList = await getWikiList();
    wikiList.add(wiki);
    await saveWikiList(wikiList);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential;
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
