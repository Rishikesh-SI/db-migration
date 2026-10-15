-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labdd_v1_web_user email_id_unq; Type: CONSTRAINT; Schema: labdd_v1_30april24; Owner: -
--

ALTER TABLE ONLY labdd_v1_30april24.labdd_v1_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
