-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labstmp_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
