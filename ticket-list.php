<?php

include 'header-init.php';
include 'jwt-helper.php';

$user = extractJwtBody();

//on recupère les tickets, l'utilisateur qui l'a créé, ainsi que le nombre de message qu'il contient
$request = $connexion->query(
    "SELECT t.id, t.nom, t.date_creation, t.date_resolution, u.firstname, u.lastname, COUNT(*) AS nombre_message
     FROM ticket AS t 
     JOIN user AS u ON t.id_createur = u.id
     JOIN message AS m ON m.id_ticket = t.id
     GROUP BY t.id
    "
);

$ticketList = $request->fetchAll();

echo json_encode($ticketList);
