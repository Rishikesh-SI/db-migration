-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labgt01_v1_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
