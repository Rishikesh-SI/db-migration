-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_entity_role_map_entity_master_id_idx
-- Type: INDEX

-- Name: labwf_entity_role_map_entity_master_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_entity_role_map_entity_master_id_idx ON fanxp_wf.labwf_entity_role_map USING btree (entity_master_id);


--
