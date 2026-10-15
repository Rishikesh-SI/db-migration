-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_web_user mobile_no_uniq
-- Type: CONSTRAINT

-- Name: isl_web_user mobile_no_uniq; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_web_user
    ADD CONSTRAINT mobile_no_uniq UNIQUE (mobile_no);


--
