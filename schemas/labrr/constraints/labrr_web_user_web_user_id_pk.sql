-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labrr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
