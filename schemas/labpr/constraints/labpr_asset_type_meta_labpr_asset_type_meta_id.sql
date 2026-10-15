-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_asset_type_meta labpr_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labpr_asset_type_meta labpr_asset_type_meta_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_asset_type_meta
    ADD CONSTRAINT labpr_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
