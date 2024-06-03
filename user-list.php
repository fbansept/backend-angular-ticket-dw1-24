<?php

include 'header-init.php';

$request = $connexion->query("  SELECT u.id, email, lastname, firstname, name AS role_name  
                                FROM user AS u 
                                JOIN role AS r ON u.id_role = r.id");

$userList = $request->fetchAll();

echo json_encode($userList);
