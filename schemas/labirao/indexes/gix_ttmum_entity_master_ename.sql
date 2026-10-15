-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labirao.labirao_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
