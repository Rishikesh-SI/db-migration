-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_asset_group labstrd_asset_group_id
-- Type: CONSTRAINT

-- Name: labstrd_asset_group labstrd_asset_group_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_asset_group
    ADD CONSTRAINT labstrd_asset_group_id PRIMARY KEY (asset_group_id);


--
