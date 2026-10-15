-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_asset_type_meta dd_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: dd_asset_type_meta dd_asset_type_meta_id; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_asset_type_meta
    ADD CONSTRAINT dd_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
