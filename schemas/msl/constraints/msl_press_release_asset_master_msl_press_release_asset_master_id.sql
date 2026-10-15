-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_press_release_asset_master msl_press_release_asset_master_id
-- Type: CONSTRAINT

-- Name: msl_press_release_asset_master msl_press_release_asset_master_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_press_release_asset_master
    ADD CONSTRAINT msl_press_release_asset_master_id PRIMARY KEY (asset_id);


--
