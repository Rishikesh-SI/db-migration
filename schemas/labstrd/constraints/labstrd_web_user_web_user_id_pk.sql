-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labstrd_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
