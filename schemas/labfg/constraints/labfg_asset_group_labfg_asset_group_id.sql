-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_asset_group labfg_asset_group_id
-- Type: CONSTRAINT

-- Name: labfg_asset_group labfg_asset_group_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_asset_group
    ADD CONSTRAINT labfg_asset_group_id PRIMARY KEY (asset_group_id);


--
