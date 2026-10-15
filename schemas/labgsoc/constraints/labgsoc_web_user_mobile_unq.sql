-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labgsoc_web_user mobile_unq; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
