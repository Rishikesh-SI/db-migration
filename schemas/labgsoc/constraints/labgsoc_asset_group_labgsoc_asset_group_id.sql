-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_asset_group labgsoc_asset_group_id
-- Type: CONSTRAINT

-- Name: labgsoc_asset_group labgsoc_asset_group_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_asset_group
    ADD CONSTRAINT labgsoc_asset_group_id PRIMARY KEY (asset_group_id);


--
