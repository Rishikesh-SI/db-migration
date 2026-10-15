-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labupw_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labupw; Owner: -
--

ALTER TABLE ONLY labupw.labupw_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
