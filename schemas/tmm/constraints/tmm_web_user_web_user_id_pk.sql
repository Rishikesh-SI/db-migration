-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: tmm_web_user web_user_id_pk; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
