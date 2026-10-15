-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labso_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labso_bkp; Owner: -
--

ALTER TABLE ONLY labso_bkp.labso_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
