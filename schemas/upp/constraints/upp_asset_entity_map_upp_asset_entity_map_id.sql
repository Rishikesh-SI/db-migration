-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_asset_entity_map upp_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: upp_asset_entity_map upp_asset_entity_map_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_asset_entity_map
    ADD CONSTRAINT upp_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
