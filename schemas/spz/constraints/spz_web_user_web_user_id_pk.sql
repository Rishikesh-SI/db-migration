-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: spz_web_user web_user_id_pk; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
