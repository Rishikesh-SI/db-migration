-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_asset_type_meta labsrk_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labsrk_asset_type_meta labsrk_asset_type_meta_id; Type: CONSTRAINT; Schema: labsrk; Owner: -
--

ALTER TABLE ONLY labsrk.labsrk_asset_type_meta
    ADD CONSTRAINT labsrk_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
