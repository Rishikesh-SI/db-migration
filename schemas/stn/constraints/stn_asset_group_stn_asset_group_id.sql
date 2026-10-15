-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_asset_group stn_asset_group_id
-- Type: CONSTRAINT

-- Name: stn_asset_group stn_asset_group_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_asset_group
    ADD CONSTRAINT stn_asset_group_id PRIMARY KEY (asset_group_id);


--
