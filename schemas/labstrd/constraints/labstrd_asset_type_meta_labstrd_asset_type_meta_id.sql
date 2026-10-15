-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_asset_type_meta labstrd_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labstrd_asset_type_meta labstrd_asset_type_meta_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_asset_type_meta
    ADD CONSTRAINT labstrd_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
