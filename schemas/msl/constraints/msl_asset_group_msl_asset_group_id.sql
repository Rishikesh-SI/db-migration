-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_asset_group msl_asset_group_id
-- Type: CONSTRAINT

-- Name: msl_asset_group msl_asset_group_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_asset_group
    ADD CONSTRAINT msl_asset_group_id PRIMARY KEY (asset_group_id);


--
