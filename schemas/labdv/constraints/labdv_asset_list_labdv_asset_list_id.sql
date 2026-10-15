-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_asset_list labdv_asset_list_id
-- Type: CONSTRAINT

-- Name: labdv_asset_list labdv_asset_list_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_asset_list
    ADD CONSTRAINT labdv_asset_list_id PRIMARY KEY (asset_list_id);


--
