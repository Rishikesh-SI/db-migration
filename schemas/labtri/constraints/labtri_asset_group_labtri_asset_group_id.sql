-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_group labtri_asset_group_id
-- Type: CONSTRAINT

-- Name: labtri_asset_group labtri_asset_group_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_group
    ADD CONSTRAINT labtri_asset_group_id PRIMARY KEY (asset_group_id);


--
