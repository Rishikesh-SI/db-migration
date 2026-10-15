-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_entity_role_map_erid
-- Type: INDEX

-- Name: ix_scom_entity_role_map_erid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_entity_role_map_erid ON scom.scom_entity_role_map USING btree (entity_role_id);


--
