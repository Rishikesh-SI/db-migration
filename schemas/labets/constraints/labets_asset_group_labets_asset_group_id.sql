-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_asset_group labets_asset_group_id
-- Type: CONSTRAINT

-- Name: labets_asset_group labets_asset_group_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_asset_group
    ADD CONSTRAINT labets_asset_group_id PRIMARY KEY (asset_group_id);


--
