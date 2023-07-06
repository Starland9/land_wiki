import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  // Définir les informations du formulaire
  String nom = "John Doe";
  String adresse = "123 rue Example";
  String message = "Ceci est un message de test.";

  // Définir l'URL de l'API Codingmailer pour l'envoi d'e-mails
  String url = "https://codingmailer.onrender.com/send-email";

  // Définir les données à envoyer
  Map<String, dynamic> data = {
    "to": "fernan",
    "subject": "Nouveau Message",
    "message": "Nom : $nom\nAdresse : $adresse\n\n$message"
  };

  // Convertir les données en format JSON
  String payload = json.encode(data);

  // Définir les en-têtes de la requête
  Map<String, String> headers = {"Content-Type": "application/json"};

  // Envoyer la requête POST à l'API Codingmailer
  http.post(Uri.parse(url), body: payload, headers: headers).then((response) {
    // Vérifier la réponse
    if (response.statusCode == 200) {
      print("E-mail envoyé avec succès.");
    } else {
      String errorMessage = json.decode(response.body)["message"] ??
          "Erreur lors de l'envoi de l'e-mail.";
      print("Erreur : $errorMessage");
    }
  }).catchError((error) {
    print("Erreur lors de l'envoi de l'e-mail : $error");
  });
}
