<?php

include 'header-init.php';
include 'jwt-helper.php';

if (!isset($_GET['id_ticket'])) {
    echo '{"message" : "il n\'y a pas d\'identiant dans l\'URL"}';
    http_response_code(400);
    exit;
}

$user = extractJwtBody();

//tansformer le JSON en objet PHP contenant les informations du ticket
$json = file_get_contents('php://input');

// Le convertit en objet PHP
$message = json_decode($json);

//On recupère le ticket dans la bdd
$request = $connexion->prepare("SELECT * FROM ticket WHERE id = ?");
$request->execute([$_GET['id_ticket']]);
$ticket = $request->fetch();

//si ce ticket n'existe pas
if (!$ticket) {
    echo '{"message" : "Ce ticket n\'existe pas"}';
    http_response_code(404);
    exit;
}

//si l'utilisateur n'est ni le créateur du ticket ni administrateur ou gestinnaire
if ($user->id != $ticket["id_createur"] && $user->role != 'Administrateur' && $user->role != 'Gestionaire') {
    echo '{"message" : "Vous ne pouvez pas éditer ce ticket"}';
    http_response_code(403);
    exit;
}

//On ajoute le message au ticket
$request = $connexion->prepare("INSERT INTO message(contenu, id_redacteur, id_ticket) 
                                VALUES (:contenu, :id_redacteur, :id_ticket)");

$request->execute([
    "contenu" => $message->contenu,
    "id_redacteur" => $user->id,
    "id_ticket" => $_GET['id_ticket']
]);

echo '{"message" : "Le message a bien été ajouté"}';
