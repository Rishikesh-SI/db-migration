-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_asset_group labsm_asset_group_id
-- Type: CONSTRAINT

-- Name: labsm_asset_group labsm_asset_group_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_asset_group
    ADD CONSTRAINT labsm_asset_group_id PRIMARY KEY (asset_group_id);


--
