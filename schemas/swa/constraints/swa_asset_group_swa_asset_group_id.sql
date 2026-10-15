-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_group swa_asset_group_id
-- Type: CONSTRAINT

-- Name: swa_asset_group swa_asset_group_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_asset_group
    ADD CONSTRAINT swa_asset_group_id PRIMARY KEY (asset_group_id);


--
