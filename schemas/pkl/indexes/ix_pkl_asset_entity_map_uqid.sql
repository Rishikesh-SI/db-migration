-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_asset_entity_map_uqid
-- Type: INDEX

-- Name: ix_pkl_asset_entity_map_uqid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_asset_entity_map_uqid ON pkl.pkl_asset_entity_map USING btree (entity_role_map_id, asset_type_id, asset_id);


--
