-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_asset_group upy_asset_group_id
-- Type: CONSTRAINT

-- Name: upy_asset_group upy_asset_group_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_asset_group
    ADD CONSTRAINT upy_asset_group_id PRIMARY KEY (asset_group_id);


--
