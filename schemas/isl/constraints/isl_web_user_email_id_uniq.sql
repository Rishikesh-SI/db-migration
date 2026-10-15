-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_web_user email_id_uniq
-- Type: CONSTRAINT

-- Name: isl_web_user email_id_uniq; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_web_user
    ADD CONSTRAINT email_id_uniq UNIQUE (email_id);


--
