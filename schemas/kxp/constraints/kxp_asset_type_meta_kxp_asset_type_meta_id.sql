-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_asset_type_meta kxp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: kxp_asset_type_meta kxp_asset_type_meta_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_asset_type_meta
    ADD CONSTRAINT kxp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
