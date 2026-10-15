-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_asset_group tcs_asset_group_id
-- Type: CONSTRAINT

-- Name: tcs_asset_group tcs_asset_group_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_asset_group
    ADD CONSTRAINT tcs_asset_group_id PRIMARY KEY (asset_group_id);


--
