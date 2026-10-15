-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_type_meta yho_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: yho_asset_type_meta yho_asset_type_meta_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_asset_type_meta
    ADD CONSTRAINT yho_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
