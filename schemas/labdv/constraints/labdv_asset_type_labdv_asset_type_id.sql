-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_asset_type labdv_asset_type_id
-- Type: CONSTRAINT

-- Name: labdv_asset_type labdv_asset_type_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_asset_type
    ADD CONSTRAINT labdv_asset_type_id PRIMARY KEY (asset_type_id);


--
