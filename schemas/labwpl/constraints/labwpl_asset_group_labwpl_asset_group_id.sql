-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_asset_group labwpl_asset_group_id
-- Type: CONSTRAINT

-- Name: labwpl_asset_group labwpl_asset_group_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_asset_group
    ADD CONSTRAINT labwpl_asset_group_id PRIMARY KEY (asset_group_id);


--
