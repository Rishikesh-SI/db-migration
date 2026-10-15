-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_asset_type_meta hsl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: hsl_asset_type_meta hsl_asset_type_meta_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_asset_type_meta
    ADD CONSTRAINT hsl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
