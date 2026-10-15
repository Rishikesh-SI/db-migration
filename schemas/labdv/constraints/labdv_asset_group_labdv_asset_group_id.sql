-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_asset_group labdv_asset_group_id
-- Type: CONSTRAINT

-- Name: labdv_asset_group labdv_asset_group_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_asset_group
    ADD CONSTRAINT labdv_asset_group_id PRIMARY KEY (asset_group_id);


--
