-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: gix_isl_entity_master_ename
-- Type: INDEX

-- Name: gix_isl_entity_master_ename; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX gix_isl_entity_master_ename ON isl.isl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
