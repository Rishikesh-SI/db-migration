-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_web_user email_unq
-- Type: CONSTRAINT

-- Name: labkxip_web_user email_unq; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_web_user
    ADD CONSTRAINT email_unq UNIQUE (email_id);


--
