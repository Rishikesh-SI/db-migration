-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_user user_code
-- Type: CONSTRAINT

-- Name: labkkr_user user_code; Type: CONSTRAINT; Schema: labkkr_30012024; Owner: -
--

ALTER TABLE ONLY labkkr_30012024.labkkr_user
    ADD CONSTRAINT user_code UNIQUE (user_code);


--
