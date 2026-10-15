-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_asset_type msl_asset_type_id
-- Type: CONSTRAINT

-- Name: msl_asset_type msl_asset_type_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_asset_type
    ADD CONSTRAINT msl_asset_type_id PRIMARY KEY (asset_type_id);


--
