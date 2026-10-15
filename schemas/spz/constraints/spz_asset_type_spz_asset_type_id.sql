-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_asset_type spz_asset_type_id
-- Type: CONSTRAINT

-- Name: spz_asset_type spz_asset_type_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_asset_type
    ADD CONSTRAINT spz_asset_type_id PRIMARY KEY (asset_type_id);


--
