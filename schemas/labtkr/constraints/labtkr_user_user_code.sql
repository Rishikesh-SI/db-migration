-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_user user_code
-- Type: CONSTRAINT

-- Name: labtkr_user user_code; Type: CONSTRAINT; Schema: labtkr; Owner: -
--

ALTER TABLE ONLY labtkr.labtkr_user
    ADD CONSTRAINT user_code UNIQUE (user_code);


--
