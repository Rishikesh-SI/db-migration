-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: dhm_web_user web_user_id_pk; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
