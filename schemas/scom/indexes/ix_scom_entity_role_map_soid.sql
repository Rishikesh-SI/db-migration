-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_entity_role_map_soid
-- Type: INDEX

-- Name: ix_scom_entity_role_map_soid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_entity_role_map_soid ON scom.scom_entity_role_map USING btree (source_object_id);


--
