-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labgg.labgg_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
