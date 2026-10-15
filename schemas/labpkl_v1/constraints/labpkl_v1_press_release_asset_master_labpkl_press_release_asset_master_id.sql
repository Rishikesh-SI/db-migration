-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_press_release_asset_master labpkl_press_release_asset_master_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_press_release_asset_master labpkl_press_release_asset_master_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_press_release_asset_master
    ADD CONSTRAINT labpkl_press_release_asset_master_id PRIMARY KEY (asset_id);


--
