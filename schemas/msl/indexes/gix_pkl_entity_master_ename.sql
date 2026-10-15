-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: gix_pkl_entity_master_ename
-- Type: INDEX

-- Name: gix_pkl_entity_master_ename; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX gix_pkl_entity_master_ename ON msl.msl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
