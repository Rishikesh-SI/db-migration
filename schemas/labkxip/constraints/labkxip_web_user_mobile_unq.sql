-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labkxip_web_user mobile_unq; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
