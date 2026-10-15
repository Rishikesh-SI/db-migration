-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_asset_entity_map hsl_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: labhsl_asset_entity_map hsl_asset_entity_map_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_asset_entity_map
    ADD CONSTRAINT hsl_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
