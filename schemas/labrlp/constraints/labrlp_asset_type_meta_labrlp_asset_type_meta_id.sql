-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_asset_type_meta labrlp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labrlp_asset_type_meta labrlp_asset_type_meta_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_asset_type_meta
    ADD CONSTRAINT labrlp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
