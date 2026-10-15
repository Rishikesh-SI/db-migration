-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_asset_type_meta khi_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: khi_asset_type_meta khi_asset_type_meta_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_asset_type_meta
    ADD CONSTRAINT khi_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
