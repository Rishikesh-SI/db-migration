-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_press_release_asset_master labpbl_press_release_asset_master_id
-- Type: CONSTRAINT

-- Name: labpbl_press_release_asset_master labpbl_press_release_asset_master_id; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.labpbl_press_release_asset_master
    ADD CONSTRAINT labpbl_press_release_asset_master_id PRIMARY KEY (asset_id);


--
