-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_list yho_asset_list_id
-- Type: CONSTRAINT

-- Name: yho_asset_list yho_asset_list_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_asset_list
    ADD CONSTRAINT yho_asset_list_id PRIMARY KEY (asset_list_id);


--
