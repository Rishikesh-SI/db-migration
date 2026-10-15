-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_role_map_erid
-- Type: INDEX

-- Name: ix_abp_entity_role_map_erid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_role_map_erid ON abpp.abp_entity_role_map USING btree (entity_role_id);


--
