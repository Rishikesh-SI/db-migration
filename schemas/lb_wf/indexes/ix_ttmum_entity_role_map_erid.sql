-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_erid; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_erid ON lb_wf.lb_wf_entity_role_map USING btree (entity_role_id);


--
