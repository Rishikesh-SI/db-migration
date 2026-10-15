-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labecn_v1_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labecn_v1; Owner: -
--

ALTER TABLE ONLY labecn_v1.labecn_v1_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
