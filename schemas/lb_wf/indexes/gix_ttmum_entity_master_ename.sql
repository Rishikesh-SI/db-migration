-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON lb_wf.lb_wf_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
