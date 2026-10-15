-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labgt01_v1_web_user email_id_unq; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
