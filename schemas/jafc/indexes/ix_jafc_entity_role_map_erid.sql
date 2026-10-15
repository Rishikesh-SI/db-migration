-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_entity_role_map_erid
-- Type: INDEX

-- Name: ix_jafc_entity_role_map_erid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_entity_role_map_erid ON jafc.jafc_entity_role_map USING btree (entity_role_id);


--
