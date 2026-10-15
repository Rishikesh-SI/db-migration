-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_user user_code
-- Type: CONSTRAINT

-- Name: labkkr_user user_code; Type: CONSTRAINT; Schema: labkkr; Owner: -
--

ALTER TABLE ONLY labkkr.labkkr_user
    ADD CONSTRAINT user_code UNIQUE (user_code);


--
