-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_asset_group spz_asset_group_id
-- Type: CONSTRAINT

-- Name: spz_asset_group spz_asset_group_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_asset_group
    ADD CONSTRAINT spz_asset_group_id PRIMARY KEY (asset_group_id);


--
