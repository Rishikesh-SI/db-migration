-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_role_map_erid
-- Type: INDEX

-- Name: ix_hsl_entity_role_map_erid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_map_erid ON hsl.hsl_entity_role_map USING btree (entity_role_id);


--
