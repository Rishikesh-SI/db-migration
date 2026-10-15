-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_asset_type gsf_asset_type_id
-- Type: CONSTRAINT

-- Name: gsf_asset_type gsf_asset_type_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_asset_type
    ADD CONSTRAINT gsf_asset_type_id PRIMARY KEY (asset_type_id);


--
