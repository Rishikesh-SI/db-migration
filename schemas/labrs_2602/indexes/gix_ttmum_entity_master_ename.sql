-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: gix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: gix_ttmum_entity_master_ename; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX gix_ttmum_entity_master_ename ON labrs_2602.labrs_entity_master USING gin (to_tsvector('english'::regconfig, (entity_name)::text));


--
