-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_asset_type_meta upp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: upp_asset_type_meta upp_asset_type_meta_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_asset_type_meta
    ADD CONSTRAINT upp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
