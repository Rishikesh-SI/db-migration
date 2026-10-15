-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_entity_language_map_language_master_id_idx
-- Type: INDEX

-- Name: upstox_entity_language_map_language_master_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_entity_language_map_language_master_id_idx ON labupstox.labupstox_entity_language_map USING btree (language_master_id);


--
