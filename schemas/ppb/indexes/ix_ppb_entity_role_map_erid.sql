-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ppb_entity_role_map_erid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_entity_role_map_erid ON ppb.ppb_entity_role_map USING btree (entity_role_id);


--
