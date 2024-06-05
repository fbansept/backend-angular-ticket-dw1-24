<?php

include 'header-init.php';
include 'jwt-helper.php';

$user = extractJwtBody();

if (!isset($_GET['id_ticket'])) {
    echo '{"message" : "il n\'y a pas d\'identiant dans l\'URL"}';
    http_response_code(400);
    exit;
}

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

$requete = $connexion->prepare("UPDATE ticket SET 
                                    date_resolution = NOW()
                                WHERE id = :id");

$requete->execute([
    "id" => $_GET['id_ticket']
]);

echo '{"message" : "Le ticket est marqué comme résolue"}';
