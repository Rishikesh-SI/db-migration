-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_asset_type labrstg_asset_type_id
-- Type: CONSTRAINT

-- Name: labrstg_asset_type labrstg_asset_type_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_asset_type
    ADD CONSTRAINT labrstg_asset_type_id PRIMARY KEY (asset_type_id);


--
