-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_asset_list labgt_asset_list_id
-- Type: CONSTRAINT

-- Name: labgt_asset_list labgt_asset_list_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_asset_list
    ADD CONSTRAINT labgt_asset_list_id PRIMARY KEY (asset_list_id);


--
