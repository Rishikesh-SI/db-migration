-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labbr.labbr_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
