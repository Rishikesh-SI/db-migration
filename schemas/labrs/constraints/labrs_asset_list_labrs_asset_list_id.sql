-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_asset_list labrs_asset_list_id
-- Type: CONSTRAINT

-- Name: labrs_asset_list labrs_asset_list_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_asset_list
    ADD CONSTRAINT labrs_asset_list_id PRIMARY KEY (asset_list_id);


--
