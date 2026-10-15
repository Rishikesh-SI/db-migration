-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_type_meta mum_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: dhm_asset_type_meta mum_asset_type_meta_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_type_meta
    ADD CONSTRAINT mum_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
