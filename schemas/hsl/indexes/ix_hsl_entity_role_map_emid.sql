-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_role_map_emid
-- Type: INDEX

-- Name: ix_hsl_entity_role_map_emid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_map_emid ON hsl.hsl_entity_role_map USING btree (entity_master_id);


--
