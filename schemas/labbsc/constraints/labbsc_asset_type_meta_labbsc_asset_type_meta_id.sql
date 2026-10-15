-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_asset_type_meta labbsc_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labbsc_asset_type_meta labbsc_asset_type_meta_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_asset_type_meta
    ADD CONSTRAINT labbsc_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
