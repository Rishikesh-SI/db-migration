-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_entity_role_map_erid
-- Type: INDEX

-- Name: ix_dd_entity_role_map_erid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_entity_role_map_erid ON dd.dd_entity_role_map USING btree (entity_role_id);


--
