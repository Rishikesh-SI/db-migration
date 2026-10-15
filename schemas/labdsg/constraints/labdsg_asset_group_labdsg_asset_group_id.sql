-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_asset_group labdsg_asset_group_id
-- Type: CONSTRAINT

-- Name: labdsg_asset_group labdsg_asset_group_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_asset_group
    ADD CONSTRAINT labdsg_asset_group_id PRIMARY KEY (asset_group_id);


--
