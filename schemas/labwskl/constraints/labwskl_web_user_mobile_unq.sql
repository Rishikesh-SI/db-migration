-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labwskl_web_user mobile_unq; Type: CONSTRAINT; Schema: labwskl; Owner: -
--

ALTER TABLE ONLY labwskl.labwskl_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
