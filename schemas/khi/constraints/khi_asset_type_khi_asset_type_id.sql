-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_asset_type khi_asset_type_id
-- Type: CONSTRAINT

-- Name: khi_asset_type khi_asset_type_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_asset_type
    ADD CONSTRAINT khi_asset_type_id PRIMARY KEY (asset_type_id);


--
