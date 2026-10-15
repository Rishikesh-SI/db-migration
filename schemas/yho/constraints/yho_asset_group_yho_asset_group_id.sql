-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_group yho_asset_group_id
-- Type: CONSTRAINT

-- Name: yho_asset_group yho_asset_group_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_asset_group
    ADD CONSTRAINT yho_asset_group_id PRIMARY KEY (asset_group_id);


--
