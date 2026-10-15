-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labwf_web_user mobile_unq; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
