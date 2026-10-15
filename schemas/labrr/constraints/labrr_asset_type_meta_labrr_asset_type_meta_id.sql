-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_asset_type_meta labrr_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labrr_asset_type_meta labrr_asset_type_meta_id; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_asset_type_meta
    ADD CONSTRAINT labrr_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
