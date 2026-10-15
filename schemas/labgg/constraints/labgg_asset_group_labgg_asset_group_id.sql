-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_asset_group labgg_asset_group_id
-- Type: CONSTRAINT

-- Name: labgg_asset_group labgg_asset_group_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_asset_group
    ADD CONSTRAINT labgg_asset_group_id PRIMARY KEY (asset_group_id);


--
