-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_academy_fee dd_academy_fee_id
-- Type: CONSTRAINT

-- Name: labbr_academy_fee dd_academy_fee_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_academy_fee
    ADD CONSTRAINT dd_academy_fee_id PRIMARY KEY (academy_fee_id);


--
