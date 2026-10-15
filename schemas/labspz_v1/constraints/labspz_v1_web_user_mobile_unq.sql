-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labspz_v1_web_user mobile_unq; Type: CONSTRAINT; Schema: labspz_v1; Owner: -
--

ALTER TABLE ONLY labspz_v1.labspz_v1_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
