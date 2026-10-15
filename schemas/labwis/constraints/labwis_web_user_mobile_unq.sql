-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labwis_web_user mobile_unq; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
