-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_asset_type_meta isl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: isl_asset_type_meta isl_asset_type_meta_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_asset_type_meta
    ADD CONSTRAINT isl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
