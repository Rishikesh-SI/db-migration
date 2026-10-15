-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labilt_web_user mobile_unq; Type: CONSTRAINT; Schema: labilt; Owner: -
--

ALTER TABLE ONLY labilt.labilt_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
