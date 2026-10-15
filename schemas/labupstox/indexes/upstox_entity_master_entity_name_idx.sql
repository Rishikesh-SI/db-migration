-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_entity_master_entity_name_idx
-- Type: INDEX

-- Name: upstox_entity_master_entity_name_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_entity_master_entity_name_idx ON labupstox.labupstox_entity_master USING btree (entity_name);


--
