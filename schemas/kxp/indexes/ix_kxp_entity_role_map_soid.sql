-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_entity_role_map_soid
-- Type: INDEX

-- Name: ix_kxp_entity_role_map_soid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_entity_role_map_soid ON kxp.kxp_entity_role_map USING btree (source_object_id);


--
