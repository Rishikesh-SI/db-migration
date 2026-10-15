-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_asset_type_meta labgsoc_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labgsoc_asset_type_meta labgsoc_asset_type_meta_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_asset_type_meta
    ADD CONSTRAINT labgsoc_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
