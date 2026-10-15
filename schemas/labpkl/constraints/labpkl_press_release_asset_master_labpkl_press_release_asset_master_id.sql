-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_press_release_asset_master labpkl_press_release_asset_master_id
-- Type: CONSTRAINT

-- Name: labpkl_press_release_asset_master labpkl_press_release_asset_master_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_press_release_asset_master
    ADD CONSTRAINT labpkl_press_release_asset_master_id PRIMARY KEY (asset_id);


--
