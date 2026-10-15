-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_asset_type upy_asset_type_id
-- Type: CONSTRAINT

-- Name: upy_asset_type upy_asset_type_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_asset_type
    ADD CONSTRAINT upy_asset_type_id PRIMARY KEY (asset_type_id);


--
