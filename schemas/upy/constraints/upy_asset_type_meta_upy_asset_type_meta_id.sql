-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_asset_type_meta upy_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: upy_asset_type_meta upy_asset_type_meta_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_asset_type_meta
    ADD CONSTRAINT upy_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
