-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labw88.labw88_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
