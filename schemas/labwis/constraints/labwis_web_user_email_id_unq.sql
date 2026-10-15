-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labwis_web_user email_id_unq; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
