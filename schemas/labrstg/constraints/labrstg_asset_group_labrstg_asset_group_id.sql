-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_asset_group labrstg_asset_group_id
-- Type: CONSTRAINT

-- Name: labrstg_asset_group labrstg_asset_group_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_asset_group
    ADD CONSTRAINT labrstg_asset_group_id PRIMARY KEY (asset_group_id);


--
