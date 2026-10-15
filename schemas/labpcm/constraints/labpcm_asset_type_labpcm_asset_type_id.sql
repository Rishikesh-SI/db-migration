-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_asset_type labpcm_asset_type_id
-- Type: CONSTRAINT

-- Name: labpcm_asset_type labpcm_asset_type_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_asset_type
    ADD CONSTRAINT labpcm_asset_type_id PRIMARY KEY (asset_type_id);


--
