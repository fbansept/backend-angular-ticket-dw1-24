<?php

include 'header-init.php';
include 'jwt-helper.php';

$user = extractJwtBody();

//tansformer le JSON en objet PHP contenant les informations du ticket
$json = file_get_contents('php://input');

// Le convertit en objet PHP
$ticket = json_decode($json);

//On ajoute le ticket dans la base de données
$request = $connexion->prepare("INSERT INTO ticket(nom, id_createur, date_creation) 
                                VALUES (:nom, :id_createur, NOW())");
//note : le redacteur est la personne connecté (son id provient du JWT)
$request->execute([
    "nom" => $ticket->nom,
    "id_createur" => $user->id
]);

$idTicket = $connexion->lastInsertId();

//On ajoute le premier message du ticket
$request = $connexion->prepare("INSERT INTO message(contenu, id_redacteur, id_ticket) 
                                VALUES (:contenu, :id_redacteur, :id_ticket)");

$request->execute([
    "contenu" => $ticket->contenu,
    "id_redacteur" => $user->id,
    "id_ticket" => $idTicket
]);

echo '{"message" : "Le ticket a bien été ajouté"}';
