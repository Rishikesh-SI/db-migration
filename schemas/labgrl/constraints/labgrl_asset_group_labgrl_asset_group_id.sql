-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_asset_group labgrl_asset_group_id
-- Type: CONSTRAINT

-- Name: labgrl_asset_group labgrl_asset_group_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_asset_group
    ADD CONSTRAINT labgrl_asset_group_id PRIMARY KEY (asset_group_id);


--
