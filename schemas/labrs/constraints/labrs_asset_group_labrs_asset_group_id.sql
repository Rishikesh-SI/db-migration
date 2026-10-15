-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_asset_group labrs_asset_group_id
-- Type: CONSTRAINT

-- Name: labrs_asset_group labrs_asset_group_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_asset_group
    ADD CONSTRAINT labrs_asset_group_id PRIMARY KEY (asset_group_id);


--
