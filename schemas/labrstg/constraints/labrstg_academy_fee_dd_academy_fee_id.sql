-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_academy_fee dd_academy_fee_id
-- Type: CONSTRAINT

-- Name: labrstg_academy_fee dd_academy_fee_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_academy_fee
    ADD CONSTRAINT dd_academy_fee_id PRIMARY KEY (academy_fee_id);


--
