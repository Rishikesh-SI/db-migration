-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_entity_role_entity_group_id_idx
-- Type: INDEX

-- Name: upstox_entity_role_entity_group_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_entity_role_entity_group_id_idx ON labupstox.labupstox_entity_role USING btree (entity_group_id);


--
