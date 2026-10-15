-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_user labyho_user_id
-- Type: CONSTRAINT

-- Name: labdms_user labyho_user_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_user
    ADD CONSTRAINT labyho_user_id PRIMARY KEY (user_id);


--
