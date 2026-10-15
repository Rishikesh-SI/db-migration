-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_asset_list ppb_asset_list_id
-- Type: CONSTRAINT

-- Name: ppb_asset_list ppb_asset_list_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_asset_list
    ADD CONSTRAINT ppb_asset_list_id PRIMARY KEY (asset_list_id);


--
