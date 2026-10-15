-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_asset_type_meta tcs_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: tcs_asset_type_meta tcs_asset_type_meta_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_asset_type_meta
    ADD CONSTRAINT tcs_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
