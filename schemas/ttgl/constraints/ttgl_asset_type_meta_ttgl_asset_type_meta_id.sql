-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_asset_type_meta ttgl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: ttgl_asset_type_meta ttgl_asset_type_meta_id; Type: CONSTRAINT; Schema: ttgl; Owner: -
--

ALTER TABLE ONLY ttgl.ttgl_asset_type_meta
    ADD CONSTRAINT ttgl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
