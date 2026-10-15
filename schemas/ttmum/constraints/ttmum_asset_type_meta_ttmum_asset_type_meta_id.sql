-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_asset_type_meta ttmum_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: ttmum_asset_type_meta ttmum_asset_type_meta_id; Type: CONSTRAINT; Schema: ttmum; Owner: -
--

ALTER TABLE ONLY ttmum.ttmum_asset_type_meta
    ADD CONSTRAINT ttmum_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
