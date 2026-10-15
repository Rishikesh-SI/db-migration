-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_entity_role_map_erid
-- Type: INDEX

-- Name: ix_upp_entity_role_map_erid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_entity_role_map_erid ON upp.upp_entity_role_map USING btree (entity_role_id);


--
