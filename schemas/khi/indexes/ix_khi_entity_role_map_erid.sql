-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_role_map_erid
-- Type: INDEX

-- Name: ix_khi_entity_role_map_erid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_role_map_erid ON khi.khi_entity_role_map USING btree (entity_role_id);


--
