-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labso_web_user email_id_unq; Type: CONSTRAINT; Schema: labso_bkp; Owner: -
--

ALTER TABLE ONLY labso_bkp.labso_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
