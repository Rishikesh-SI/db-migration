-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_role_map_erid
-- Type: INDEX

-- Name: ix_isl_entity_role_map_erid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_role_map_erid ON isl.isl_entity_role_map USING btree (entity_role_id);


--
