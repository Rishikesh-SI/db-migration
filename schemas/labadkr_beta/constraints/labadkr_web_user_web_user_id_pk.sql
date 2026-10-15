-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labadkr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labadkr_beta; Owner: -
--

ALTER TABLE ONLY labadkr_beta.labadkr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
