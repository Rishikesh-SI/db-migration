-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_asset_type_meta labrao_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labrao_asset_type_meta labrao_asset_type_meta_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_asset_type_meta
    ADD CONSTRAINT labrao_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
