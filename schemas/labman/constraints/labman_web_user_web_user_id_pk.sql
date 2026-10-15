-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labman_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
