-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_asset_type tcs_asset_type_id
-- Type: CONSTRAINT

-- Name: tcs_asset_type tcs_asset_type_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_asset_type
    ADD CONSTRAINT tcs_asset_type_id PRIMARY KEY (asset_type_id);


--
