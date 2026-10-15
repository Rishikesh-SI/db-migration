-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labbsc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
