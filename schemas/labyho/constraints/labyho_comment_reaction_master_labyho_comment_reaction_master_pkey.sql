-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_comment_reaction_master labyho_comment_reaction_master_pkey
-- Type: CONSTRAINT

-- Name: labyho_comment_reaction_master labyho_comment_reaction_master_pkey; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_comment_reaction_master
    ADD CONSTRAINT labyho_comment_reaction_master_pkey PRIMARY KEY (comment_id);


--
