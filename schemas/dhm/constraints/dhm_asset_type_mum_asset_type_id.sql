-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_type mum_asset_type_id
-- Type: CONSTRAINT

-- Name: dhm_asset_type mum_asset_type_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_type
    ADD CONSTRAINT mum_asset_type_id PRIMARY KEY (asset_type_id);


--
