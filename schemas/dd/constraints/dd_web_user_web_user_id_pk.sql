-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: dd_web_user web_user_id_pk; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
