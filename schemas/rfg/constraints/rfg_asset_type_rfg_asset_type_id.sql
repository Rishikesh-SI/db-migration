-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_asset_type rfg_asset_type_id
-- Type: CONSTRAINT

-- Name: rfg_asset_type rfg_asset_type_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_asset_type
    ADD CONSTRAINT rfg_asset_type_id PRIMARY KEY (asset_type_id);


--
