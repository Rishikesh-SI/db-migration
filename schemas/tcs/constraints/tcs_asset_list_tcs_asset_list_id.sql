-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_asset_list tcs_asset_list_id
-- Type: CONSTRAINT

-- Name: tcs_asset_list tcs_asset_list_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_asset_list
    ADD CONSTRAINT tcs_asset_list_id PRIMARY KEY (asset_list_id);


--
