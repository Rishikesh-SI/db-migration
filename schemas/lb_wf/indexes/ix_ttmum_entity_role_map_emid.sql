-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON lb_wf.lb_wf_entity_role_map USING btree (entity_master_id);


--
