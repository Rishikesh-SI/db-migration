-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_asset_group jafc_asset_group_id
-- Type: CONSTRAINT

-- Name: jafc_asset_group jafc_asset_group_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_asset_group
    ADD CONSTRAINT jafc_asset_group_id PRIMARY KEY (asset_group_id);


--
