-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labgt01_v1.labgt01_v1_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
