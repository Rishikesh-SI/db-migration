-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_role_map_erid
-- Type: INDEX

-- Name: ix_yho_entity_role_map_erid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_role_map_erid ON yho.yho_entity_role_map USING btree (entity_role_id);


--
