-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labrr_beta_08042024.labrr_asset_entity_map USING btree (asset_type_id);


--
