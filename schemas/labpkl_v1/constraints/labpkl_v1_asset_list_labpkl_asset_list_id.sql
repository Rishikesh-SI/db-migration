-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_asset_list labpkl_asset_list_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_asset_list labpkl_asset_list_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_asset_list
    ADD CONSTRAINT labpkl_asset_list_id PRIMARY KEY (asset_list_id);


--
