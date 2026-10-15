-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_asset_group rfg_asset_group_id
-- Type: CONSTRAINT

-- Name: rfg_asset_group rfg_asset_group_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_asset_group
    ADD CONSTRAINT rfg_asset_group_id PRIMARY KEY (asset_group_id);


--
