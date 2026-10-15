-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: gix_ttgl_entity_master_ename
-- Type: INDEX

-- Name: gix_ttgl_entity_master_ename; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX gix_ttgl_entity_master_ename ON ttgl.ttgl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
