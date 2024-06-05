<?php

include 'header-init.php';
include 'jwt-helper.php';

$ticket = extractJwtBody();

if (!isset($_GET['id'])) {
    echo '{"message" : "il n\'y a pas d\'identiant dans l\'URL"}';
    http_response_code(400);
    exit;
}

$idTicket = $_GET["id"];

//on récupère tous les messages du ticket et leurs rédacteurs

$requete = $connexion->prepare("SELECT t.nom, m.contenu, u.firstname , u.lastname
                                FROM ticket AS t
                                JOIN message AS m ON m.id_ticket = t.id
                                JOIN user AS u ON m.id_redacteur = u.id
                                WHERE t.id = ?
                                ORDER BY m.id");
$requete->execute([$idTicket]);

$ticketBdd = $requete->fetchAll();

if (!$ticketBdd) {
    echo json_encode(["message" => "ticket inexistant"]);
    http_response_code(404);
    exit;
}

echo json_encode($ticketBdd);
