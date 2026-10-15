-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_entity_role_map_erid
-- Type: INDEX

-- Name: ix_zeven_entity_role_map_erid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_entity_role_map_erid ON zeven.zeven_entity_role_map USING btree (entity_role_id);


--
