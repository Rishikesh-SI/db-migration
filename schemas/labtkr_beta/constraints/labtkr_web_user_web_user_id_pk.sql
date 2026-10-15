-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labtkr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
