-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_web_user email_id_uniq
-- Type: CONSTRAINT

-- Name: labisl_v1_web_user email_id_uniq; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_web_user
    ADD CONSTRAINT email_id_uniq UNIQUE (email_id);


--
