-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_asset_entity_map hsl_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: hsl_asset_entity_map hsl_asset_entity_map_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_asset_entity_map
    ADD CONSTRAINT hsl_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
