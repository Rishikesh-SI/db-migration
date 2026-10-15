-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_asset_entity_map kxp_asset_entity_map_id
-- Type: CONSTRAINT

-- Name: kxp_asset_entity_map kxp_asset_entity_map_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_asset_entity_map
    ADD CONSTRAINT kxp_asset_entity_map_id PRIMARY KEY (asset_entity_map_id);


--
