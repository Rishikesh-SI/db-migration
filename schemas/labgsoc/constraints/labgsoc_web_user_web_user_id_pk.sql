-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labgsoc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
