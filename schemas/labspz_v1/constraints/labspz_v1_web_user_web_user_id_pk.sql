-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labspz_v1_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labspz_v1; Owner: -
--

ALTER TABLE ONLY labspz_v1.labspz_v1_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
