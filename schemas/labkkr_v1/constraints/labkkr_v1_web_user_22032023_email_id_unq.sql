-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_web_user_22032023 email_id_unq
-- Type: CONSTRAINT

-- Name: labkkr_v1_web_user_22032023 email_id_unq; Type: CONSTRAINT; Schema: labkkr_v1; Owner: -
--

ALTER TABLE ONLY labkkr_v1.labkkr_v1_web_user_22032023
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
