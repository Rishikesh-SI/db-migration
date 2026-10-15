-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_asset_type_meta labgg_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labgg_asset_type_meta labgg_asset_type_meta_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_asset_type_meta
    ADD CONSTRAINT labgg_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
