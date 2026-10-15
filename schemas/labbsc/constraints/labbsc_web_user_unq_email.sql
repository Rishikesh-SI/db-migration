-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_web_user unq_email
-- Type: CONSTRAINT

-- Name: labbsc_web_user unq_email; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_web_user
    ADD CONSTRAINT unq_email UNIQUE (email_id);


--
