-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_asset_type_meta stn_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: stn_asset_type_meta stn_asset_type_meta_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_asset_type_meta
    ADD CONSTRAINT stn_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
