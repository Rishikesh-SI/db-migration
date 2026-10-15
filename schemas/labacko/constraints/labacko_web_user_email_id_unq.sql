-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labacko_web_user email_id_unq; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
