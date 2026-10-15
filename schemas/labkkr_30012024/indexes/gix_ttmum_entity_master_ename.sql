-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labkkr_30012024.labkkr_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
