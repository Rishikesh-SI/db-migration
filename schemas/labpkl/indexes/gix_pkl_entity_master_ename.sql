-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: gix_pkl_entity_master_ename
-- Type: INDEX

-- Name: gix_pkl_entity_master_ename; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX gix_pkl_entity_master_ename ON labpkl.labpkl_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
