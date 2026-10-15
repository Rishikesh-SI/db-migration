-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labos_web_user mobile_unq; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
