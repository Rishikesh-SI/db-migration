-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_user user_code_unq
-- Type: CONSTRAINT

-- Name: labkkr_v1_user user_code_unq; Type: CONSTRAINT; Schema: labkkr_v1; Owner: -
--

ALTER TABLE ONLY labkkr_v1.labkkr_v1_user
    ADD CONSTRAINT user_code_unq UNIQUE (user_code);


--
