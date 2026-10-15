-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labbr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
