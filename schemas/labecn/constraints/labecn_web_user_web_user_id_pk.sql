-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labecn_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labecn; Owner: -
--

ALTER TABLE ONLY labecn.labecn_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
