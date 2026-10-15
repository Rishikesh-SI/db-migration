-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_web_user mobile_unq
-- Type: CONSTRAINT

-- Name: labtri_web_user mobile_unq; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_web_user
    ADD CONSTRAINT mobile_unq UNIQUE (mobile_no);


--
