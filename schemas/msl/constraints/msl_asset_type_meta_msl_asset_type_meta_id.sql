-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_asset_type_meta msl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: msl_asset_type_meta msl_asset_type_meta_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_asset_type_meta
    ADD CONSTRAINT msl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
