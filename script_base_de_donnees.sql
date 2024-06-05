
CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `id_redacteur` int(11) NOT NULL,
  `id_ticket` int(11) NOT NULL,
  `contenu` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`id`, `id_redacteur`, `id_ticket`, `contenu`) VALUES
(1, 2, 1, 'Le cable HDMI de la salle 101 ne marche pas parfaitement'),
(2, 1, 1, 'Quels sont les symptôme ?'),
(3, 2, 1, 'L\'écran reste noir'),
(8, 3, 2, 'Le réseau est super lent aujourd\'hui'),
(9, 3, 3, 'Mon PC manque de RAM');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'Etudiant'),
(2, 'Gestionnaire'),
(3, 'Administrateur');

-- --------------------------------------------------------

--
-- Structure de la table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_resolution` datetime DEFAULT NULL,
  `id_createur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ticket`
--

INSERT INTO `ticket` (`id`, `nom`, `date_creation`, `date_resolution`, `id_createur`) VALUES
(1, ' Incident HDMI défaillant', '2024-06-03 11:49:31', '2024-06-04 11:54:42', 3),
(2, 'Incident Réseau', '2024-06-03 11:49:31', '2024-06-04 11:49:31', 2),
(3, ' Incident PC lent', '2024-06-04 11:54:19', NULL, 3);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `firstname`, `lastname`, `id_role`) VALUES
(1, 'a@a', '$2y$10$bGZTPkracHqpw4wg9XftvefJZt51GpmxcYMH/4YZsMXm6RCGJ0j6m', 'john', 'doe', 3),
(2, 'b@b', '$2y$10$bGZTPkracHqpw4wg9XftvefJZt51GpmxcYMH/4YZsMXm6RCGJ0j6m', 'franck', 'bansept', 2),
(3, 'c@c', '$2y$10$bGZTPkracHqpw4wg9XftvefJZt51GpmxcYMH/4YZsMXm6RCGJ0j6m', 'tom', 'sawyer', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ticket_message` (`id_ticket`),
  ADD KEY `FK_redacteur_ticket` (`id_redacteur`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_createur_ticket` (`id_createur`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_role_user` (`id_role`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `FK_redacteur_ticket` FOREIGN KEY (`id_redacteur`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_ticket_message` FOREIGN KEY (`id_ticket`) REFERENCES `ticket` (`id`);

--
-- Contraintes pour la table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `FK_createur_ticket` FOREIGN KEY (`id_createur`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_role_utilisateur` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`);
