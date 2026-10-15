-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON lb_wf.lb_wf_entity_master USING btree (entity_name);


--
