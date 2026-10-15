-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_entity_role_map_erid
-- Type: INDEX

-- Name: ix_hsl_entity_role_map_erid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_map_erid ON labhsl.labhsl_entity_role_map USING btree (entity_role_id);


--
