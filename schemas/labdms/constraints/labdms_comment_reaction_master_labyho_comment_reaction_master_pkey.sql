-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_comment_reaction_master labyho_comment_reaction_master_pkey
-- Type: CONSTRAINT

-- Name: labdms_comment_reaction_master labyho_comment_reaction_master_pkey; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_comment_reaction_master
    ADD CONSTRAINT labyho_comment_reaction_master_pkey PRIMARY KEY (comment_id);


--
