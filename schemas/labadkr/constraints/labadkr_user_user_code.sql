-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_user user_code
-- Type: CONSTRAINT

-- Name: labadkr_user user_code; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_user
    ADD CONSTRAINT user_code UNIQUE (user_code);


--
