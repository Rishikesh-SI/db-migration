-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_web_user_29bkp1 mobile_no_unq
-- Type: CONSTRAINT

-- Name: isl_web_user_29bkp1 mobile_no_unq; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_web_user_29bkp1
    ADD CONSTRAINT mobile_no_unq UNIQUE (mobile_no);


--
