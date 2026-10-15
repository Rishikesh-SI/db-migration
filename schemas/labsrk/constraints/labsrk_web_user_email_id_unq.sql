-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labsrk_web_user email_id_unq; Type: CONSTRAINT; Schema: labsrk; Owner: -
--

ALTER TABLE ONLY labsrk.labsrk_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
