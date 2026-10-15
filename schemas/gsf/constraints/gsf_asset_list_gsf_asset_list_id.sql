-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_asset_list gsf_asset_list_id
-- Type: CONSTRAINT

-- Name: gsf_asset_list gsf_asset_list_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_asset_list
    ADD CONSTRAINT gsf_asset_list_id PRIMARY KEY (asset_list_id);


--
