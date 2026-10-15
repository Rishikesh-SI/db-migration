-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labsm_web_user mobile_unq; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
