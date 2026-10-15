-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labets_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
