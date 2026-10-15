-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_asset_type_meta labman_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labman_asset_type_meta labman_asset_type_meta_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_asset_type_meta
    ADD CONSTRAINT labman_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
