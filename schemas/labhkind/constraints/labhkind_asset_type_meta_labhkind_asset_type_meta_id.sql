-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_asset_type_meta labhkind_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labhkind_asset_type_meta labhkind_asset_type_meta_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_asset_type_meta
    ADD CONSTRAINT labhkind_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
