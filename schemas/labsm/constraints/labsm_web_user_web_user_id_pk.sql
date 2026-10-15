-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labsm_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
